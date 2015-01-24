class ProductsController < ApplicationController
  before_action :initFilters, :set_products_per_page
  before_action :set_from_controller
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_products, only: [:index]
  before_action :set_search_and_filter_params, only: [:filter, :search, :brand, :price]
  respond_to :html, :js

  include ApplicationHelper
  include Modules::SearchModule

  helper_method :product_passed

  add_breadcrumb 'Home', :root_path

  # GET /products
  # GET /products.json
  def index
    add_breadcrumb 'Products', :products_path
    set_pages
  end

  # GET /products/1
  # GET /products/1.json
  def show
    add_breadcrumb 'Products', :products_path
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

    if @payment.save
      redirect_to @payment.paypal_url
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
    set_pages
    @products = @products.paginate(:page => @current_page, :per_page => session[:products_per_page])

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
    search_and_filter()
    set_pages
    @products = @products.paginate(:page => @current_page, :per_page => session[:products_per_page])

    respond_to do |format|
      format.html { render 'products/index' }
      format.js { render 'search.js.erb' }
    end
  end

  # GET /products/filter
  def brand
    filter_by_manufacturer()
    set_pages
    @products = @products.paginate(:page => @current_page, :per_page => session[:products_per_page])

    respond_to do |format|
      format.html { puts 'html' }
      format.js { render 'search.js.erb' }
    end
  end

  def price

    filter_by_price()
    set_pages
    @products = @products.paginate(:page => @current_page, :per_page => session[:products_per_page])

    respond_to do |format|
      format.html { puts 'html' }
      format.js { render 'search.js.erb' }
    end
  end

  def change_page
    session[:page_number] = search_params[:page_number].to_i
    search_and_filter
    set_pages
    @products = main_change_page

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

  def set_from_controller
    @from_controller = 'products'
  end

  def set_products_per_page
    session[:products_per_page] = 12
    @products_per_page = 6
    @table_css = 'col-md-4 col-sm-6 col-xs-12'
  end

  def initFilters
    @brands ||= Manufacturer.all
    @price_ranges ||= [ [0.01, 1.99, 0], [2, 4.99, 1], [5, 9.99, 2], [10.00, 15.99, 3], [16.00, 19.99, 4], [20.00, 49.99, 5], [50.00, 99.99, 6], [100, 1000, 7] ]
    @page_label = 'OUR PRODUCTS'
  end
end