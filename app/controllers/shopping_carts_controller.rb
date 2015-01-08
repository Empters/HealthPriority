class ShoppingCartsController < ApplicationController

  # Start breadcrumb root
  add_breadcrumb 'Home', :root_path

  # Index action
  def index
    add_breadcrumb 'Cart', :shopping_carts_path
  end

  def success
    puts "--------- success ------------"
  end

  def cancel
    puts "--------- cancel ------------"
  end

  def payment
    puts "--------- payments ------------"
    @payment = ActiveRecord::Base::Payment.new
  end

  def payment_params
    params.require(:payments).permit(:name, :company, :address, :city, :state, :postal_code, :country, :phone,:email, :description)
  end
end