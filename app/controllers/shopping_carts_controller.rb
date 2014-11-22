class ShoppingCartsController < ApplicationController

  # Start breadcrumb root
  add_breadcrumb 'Home', :root_path

  # Index action
  def index
    add_breadcrumb 'Cart', :shopping_carts_path
  end
end
