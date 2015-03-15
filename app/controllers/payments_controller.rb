class PaymentsController < ApplicationController

  protect_from_forgery except: [:hook]

  before_action :set_breadcrumb, only: [:show]
  before_action :init_user

  def show
    add_breadcrumb 'Payment'
    @payment = Payment.find params[:id]
  end

  def new

    # Create new payment
    @payment = Payment.new

    # If have login user - init payment with login user data
    if !@user.nil?
      @payment.gender_id = @user.gender_id
      @payment.first_name = @user.first_name
      @payment.last_name = @user.last_name
      @payment.email = @user.email
      @payment.phone = @user.phone
      @payment.fax = @user.fax
      @payment.country_id = @user.country_id
      @payment.state_id = @user.state_id
      @payment.city = @user.city
      @payment.postal_code = @user.postal_code
      @payment.address = @user.address
      @payment.second_address = @user.second_address
    end

  end

  # POST /payment
  # POST /payment.json
  def create

    @payment = Payment.new(payment_params)
    if @payment.valid?

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

      @payment.item_name = item_name
      @payment.item_number = item_number
      @payment.quantity = total_quantity
      @payment.amount = shopping_cart.total_price
      @payment.user = current_user unless user_signed_in?
    end

    if @payment.valid? && @payment.save
      redirect_to @payment.paypal_url(payment_path(@payment))
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end

  end

  def hook

    # Permit all paypal input params
    params.permit!

    @payment = Payment.find params[:invoice]
    @payment.update_attributes notification_params: params, status: params[:payment_status], transaction_id: params[:txn_id], purchased_at: Time.now
    @payment.save

    render nothing: true
  end

  def payment_params
    params.require(:payment).permit(:gender_id, :first_name, :last_name, :email, :phone, :fax, :country_id, :state_id, :city, :postal_code, :address, :second_address, :payment_method, :description)
  end

  private

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

  def init_user
    @user = user_signed_in? ? current_user : nil
  end

end
