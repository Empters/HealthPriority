class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products, :set_pages, :set_search_and_filter_params, only: [:index]
  before_action :set_from_controller

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
    #TODO - check if have by ip
    $last_visit_products ||= Product.last_visit_products.to_a()
  end

  private
    def set_from_controller
      @from_controller = 'home'
    end
end
