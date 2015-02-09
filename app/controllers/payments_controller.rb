class PaymentsController < ApplicationController

  protect_from_forgery except: [:hook]

  def show
    #TODO - show payment status
    @payment = Payment.find params[:id]
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    total_quantity = 0
    item_name = ''
    item_number = ''
    shopping_cart.products.each do |product, quantity|

      item = Item.new
      item.product_id = product.id
      item.name = product.name
      item.price = product.price
      item.quantity = quantity

      @payment.items << item

      item_name.concat(item.name).concat(';')
      total_quantity = total_quantity + quantity
      item_number.concat(quantity.to_s).concat(';')
    end
    @payment.total_quantity = total_quantity
    @payment.total = shopping_cart.total_price
    @payment.item_name = item_name
    @payment.item_number = item_number
    @payment.user = current_user unless user_signed_in?
    if @payment.save
      redirect_to @payment.paypal_url(payment_path(@payment))
    else
      render 'shopping_carts/cancel'
    end
  end

  def hook

    # Permit all Paypal input params
    params.permit!

    @payment = Payment.find params[:invoice]
    @payment.update_attributes notification_params: params, status: params[:payment_status], transaction_id: params[:txn_id], purchased_at: Time.now
    @payment.save

    render nothing: true
  end

  def payment_params
    params.require(:payment).permit(:name, :company, :address, :city, :state, :postal_code, :country, :phone, :email, :description, :payment_method)
  end

end
