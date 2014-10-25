class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products

  def set_products
    @products = Product.all
  end

end
