class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  add_breadcrumb 'Home', :root_path

  # GET /products
  # GET /products.json
  def index
    add_breadcrumb 'Products', :products_path
    $products ||= Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    add_breadcrumb 'Products', :products_pat
    add_to_last_visit_product(@product)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /products/search
  def search
    # if search_params[:token]
    #   $products = Product.where("UPPER(name) LIKE :name", {:name => "%" + search_params[:token].upcase + "%"})
    # else
    #   $products ||= Product.all
    # end

    search_and_filter(search_params[:category], search_params[:token])

    # search_and_filter(@category, '')

    respond_to do |format|
      format.js {
        if request.xhr?
          render 'search.js.erb'
        end
      }
      format.html {
        render '/products/index'
      }
    end
  end

  # GET /products/filter
  def filter
    @category = Category.find(search_params[:category])
    # if(@category.parent)
    #   $products = Product.joins(products_categories: :category).where(categories: {id: @category})
    #   else
    #   $products = Product.joins(products_categories: :category).where('categories.id = :category or categories.parent_id = :category', {:category => @category})
    # end

    search_and_filter(@category, '')

    respond_to do |format|
      format.html { puts "html" }
      format.js { render 'search.js.erb' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :model, :quantity, :viewed, :image, :price, :points, :description)
  end

  def search_params
    params.permit(:token, :format, :category)
  end

  def search_and_filter(category, token)
    if (!token && !category)
      $products = $products ||= Product.all
    elsif !category
      $products = Product.where("UPPER(name) LIKE :name", {:name => "%" + token.upcase + "%"})
    elsif !token
      @category = Category.find(search_params[:category])
      if (@category.parent)
        $products = Product.joins(products_categories: :category).where(categories: {id: @category})
      else
        $products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                        {:category => @category})
      end
    else
      @category = Category.find(search_params[:category])
      if (@category.parent)
        $products = Product.joins(products_categories: :category).where(categories: {id: @category}).where('UPPER(products.name) LIKE :token', {token: "%" + token.upcase + "%"})
      else
        $products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                        {:category => @category}).where('UPPER(products.name) LIKE :token', {token: "%" + token.upcase + "%"})
      end
    end
  end

  def add_to_last_visit_product(product)
    # Check input parameters
    if product.nil?
      return
    end

    # Change last visit products
    if $last_visit_products.nil?
      $last_visit_products = Array.new
      $last_visit_products << product
    else
      if $last_visit_products.length > 3
        $last_visit_products.delete_at($last_visit_products.length - 1)
      end
      $last_visit_products.unshift(product)
    end
  end
end