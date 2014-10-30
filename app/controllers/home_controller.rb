class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products, :set_categories

  private
    def set_categories
      @categories = Category.top_level
    end

    def set_products
      @products = Product.feature_products
    end
end
