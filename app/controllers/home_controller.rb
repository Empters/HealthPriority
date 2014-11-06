class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products

  private
    def set_products
      $products ||= Product.feature_products
    end
end
