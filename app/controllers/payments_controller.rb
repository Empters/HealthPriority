class PaymentsController < ApplicationController

  protect_from_forgery except: [:hook]

  before_action :set_breadcrumb, only: [:show]

  def show
    puts "show"
    add_breadcrumb 'Payment'

    @payment = Payment.find params[:id]
  end

  def new
    puts "new"
    @payment = Payment.new
  end

  # POST /payment
  # POST /payment.json
  def create
    puts "create"
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
      # @payment.quantity = total_quantity
      @payment.amount = shopping_cart.total_price
      @payment.user = current_user unless user_signed_in?
    end

    if @payment.valid? && @payment.save
      clear_shopping_cart
      redirect_to @payment.paypal_url(payment_path(@payment))
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end

  end

  def hook
    puts "---------------------"
    puts "hook"
    puts params
    # Permit all paypal input params
    params.permit!

    @payment = Payment.find params[:invoice]
    if @payment.status != 'Completed'

      @payment.update_attribute :status, params[:payment_status]
      @payment.update_attribute :transaction_id, params[:txn_id]
      @payment.update_attribute :purchased_at, Time.now

      @payment.save
      @payment.order.update_attributes params
    end

    render nothing: true
  end

  def payment_params
    puts 'payment controller'
    puts params
    params.require(:payment).permit(:gender_id, :first_name, :last_name, :email, :phone, :fax, :country_id, :state_id, :city, :postal_code, :address, :second_address, :payment_method, :description)
  end

  private

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

end
