class SpecialOffersController < ApplicationController

  include Modules::SearchModule

  helper_method :product_passed

  def index

    set_from_controller
    set_products_per_page

    #TODO - get spacial offers
    search_and_filter
    @products = @products.paginate(:page => @current_page, :per_page => session[:products_per_page])
    set_pages

    respond_to do |format|
      format.html { render 'special_offers/index' }
    end
  end

  # GET change_page
  def change_page
    session[:page_number] = search_params[:page_number].to_i

    #TODO - get spacial offers
    @products = search_and_filter
    set_pages
    @products = main_change_page

    respond_to do |format|
      format.js { render 'products/search.js.erb' }
    end
  end

  private

  def set_from_controller
    @from_controller = 'special_offers'
    @page_label= t('special_offers')
  end

  def set_products_per_page
    session[:products_per_page] = 12
    @products_per_page = 8
    @table_css = 'col-md-3 col-sm-4 col-xs-12'
  end

end
