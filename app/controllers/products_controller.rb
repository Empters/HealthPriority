class ProductsController < ApplicationController

  before_action :set_breadcrumb
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :init_product_list, :set_search_and_filter_params, :initFilters, only: [:index, :filter, :search]

  respond_to :html, :js

  include Modules::SearchModule

  # GET /products
  # GET /products.json
  def index

    # Get last added products
    @products = Product.order(:created_at => :desc).paginate(:page => params[:page], :per_page => @products_per_page)

  end

  # GET /products/1
  # GET /products/1.json
  def show
    add_breadcrumb t('products'), :products_path
    add_breadcrumb @product.name, @product
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

    if @order.save
      redirect_to @order.paypal_url
    else
      render nothing: true
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

    search_and_filter()

    @products = @products.paginate(:page => params[:page], :per_page => @products_per_page)

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

  # GET /products/autocomplete
  def autocomplete
    render json: params[:query].blank? ? nil : Product.where('UPPER(name) LIKE :query or UPPER(description) LIKE :query', {:query => "%#{params[:query].upcase}%"}).limit(10)
  end

  # GET /products/filter
  def filter

    search_and_filter()

    @products = @products.paginate(:page => params[:page], :per_page => @products_per_page)

    respond_to do |format|
      format.html { render 'products/index' }
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

  def init_product_list
    init_product_list_view(t('our_products'), 12, 4, 'col-md-3 col-sm-4 col-xs-12')
  end

  def initFilters
    @page_name = 'Health Care Products'
    @brands ||= Manufacturer.all
    @price_ranges ||= [ [0.01, 1.99, 0], [2, 4.99, 1], [5, 9.99, 2], [10.00, 15.99, 3], [16.00, 19.99, 4], [20.00, 49.99, 5], [50.00, 99.99, 6], [100, 1000, 7] ]
  end

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end
end