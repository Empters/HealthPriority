class ShoppingCardsController < ApplicationController

  # Start breadcrumb root
  add_breadcrumb 'Home', :root_path

  # Index action
  def index
    add_breadcrumb 'Cart', :shopping_cards_path
  end
end
