class ShoppingCartsController < ApplicationController

  # Start breadcrumb root
  add_breadcrumb 'Home', :root_path

  # Index action
  def index
    add_breadcrumb 'Cart', :shopping_carts_path
  end

  def pay
    puts "--------- pay ------------"

    @payment = Payment.new
    if @payment.save
      redirect_to @payment.paypal_url
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    puts "--------- hook ------------"

    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @payment = Payment.find params[:invoice]
      @payment.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end


  def success
    puts "--------- success ------------"
  end

  def cancel
    puts "--------- cancel ------------"
  end

  def payment
    puts "--------- payment ------------"
    @payment = ActiveRecord::Base::Payment.new
  end

  def payment_params
    params.require(:payment).permit(:name, :company, :address, :city, :state, :postal_code, :country, :phone,:email, :description)
  end
end