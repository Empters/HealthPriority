class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    puts "!!!!!!!!!!! create !!!!!!!!!!!!!!"

    @shopping_cart = shopping_cart

    @payment = Payment.new(payment_params)
    total_quantity = 0
    item_name = ''
    item_number = ''
    @shopping_cart.products.each do |product, quantity|
      item = Item.new
      item.quantity = quantity
      item.price = product.price
      item.name = product.name
      total_quantity = total_quantity + quantity
      @payment.items << item
      item_name.concat(item.name).concat('_')
    end
    @payment.total_quantity = total_quantity
    @payment.total=shopping_cart.total_price
    @payment.item_name=item_name
    @payment.item_number=item_number

    @payment.user = current_user unless user_signed_in?

    if @payment.save
      redirect_to @payment.paypal_url(payment_path(@payment))
    else
      render 'shopping_carts/cancel'
    end
  end

  protect_from_forgery except: [:hook, :show]
  def hook
    puts "--------- hook ------------"
    clear_shopping_cart
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    puts "status = ", status
    if status == "Completed"
      @payment = Payment.find params[:invoice]
      @payment.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
      @payment.save
    end
    render nothing: true
  end

  def show
    puts "show"
    puts params
  end

  def payment_params
    params.require(:payment).permit(:name, :company, :address, :city, :state, :postal_code, :country, :phone,:email, :description)
  end
end
