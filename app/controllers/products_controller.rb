class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_products, :set_pages, :set_from_controller, only: [:search, :filter]
  respond_to :html, :js

  include Modules::SearchModule

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
    search_and_filter(search_params[:category], search_params[:token])
    set_pages
    $products = $products.paginate(:page => @current_page, :per_page => 6)
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

  def change_page
    main_change_page

    respond_to do |format|
      format.js { render 'products/search.js.erb' }
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
end