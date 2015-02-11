class ShoppingCartsController < ApplicationController
  before_action :set_breadcrumb
  before_action :init_product, only: [:add_to_shopping_cart, :remove_product]

  # Index action
  def index
    add_breadcrumb t('shopping_cart'), :shopping_carts_path
  end

  # Get /add_to_shopping_cart
  def add_to_shopping_cart
    product_quantity = params[:quantity].to_i()
    shopping_cart.add_product_to_cart(@product, product_quantity)
    flash[:success] = product_quantity > 0 ? 'The product is added successful!' : 'The product is removed successful!'
    respond_to do |format|
      format.js {
        render 'shopping_carts/refresh_shopping_cart'
      }
    end
  end

  # POST /set_product_count
  def set_product_count
    @product = Product.find(params[:product_id].to_i())
    @product_count = params[:count].to_i()
    shopping_cart.set_product_count(@product, @product_count)
    respond_to do |format|
      format.js {
        render 'shopping_carts/refresh_shopping_cart'
      }
    end
  end

  # Delete /remove_product
  def remove_product
    shopping_cart.remove_product_from_cart(@product)
    flash[:success] = 'The product is removed successful!'
    respond_to do |format|
      format.js {
        render 'shopping_carts/refresh_shopping_cart'
      }
    end
  end

  def success
  end

  def cancel
  end

  def payment
    @payment = ActiveRecord::Base::Payment.new
  end

  def payment_params
    params.require(:payments).permit(:name, :company, :address, :city, :state, :postal_code, :country, :phone, :email, :description)
  end

  private

  def init_product
    @product = Product.find(params[:id])
  end

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end
end