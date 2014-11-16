class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    # Index every time call get feature products - refresh products
    $products = Product.feature_products

    #TODO - check if have by ip
    $last_visit_products ||= Product.last_visit_products.to_a()
  end

end
