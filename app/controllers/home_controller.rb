class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products

  private
    def set_products
      $products ||= Product.paginate(:page => params[:page], :per_page => 6)
    end
end
