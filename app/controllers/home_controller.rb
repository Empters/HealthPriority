class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products_per_page
  before_action :set_products, :set_pages, :set_search_and_filter_params, only: [:index]
  before_action :set_from_controller
  before_action :set_best_sellers

  include Modules::SearchModule

  helper_method :product_passed

  def change_page
    session[:page_number] = search_params[:page_number].to_i

    @products = search_and_filter
    set_pages
    @products = main_change_page

    respond_to do |format|
      format.js { render 'products/search.js.erb' }
    end
  end

  def index
  end

  private
    def set_from_controller
      @from_controller = 'home'
    end

    def set_products_per_page
      session[:products_per_page] = 8
      @products_per_page = 8
      @table_css = 'col-md-3 col-sm-4 col-xs-12'
    end

    def set_best_sellers
      @best_sellers = Product.where(is_best_seller: true)
    end
end
