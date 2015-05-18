class OrdersController < ApplicationController

  protect_from_forgery except: [:hook]

  before_action :set_breadcrumb, only: [:index, :show]
  before_action :init_user

  def index
    add_breadcrumb t('order_history')
    @page_title = t('order_history')
    @orders= @user.nil? ? nil : Order.where(:user_id => @user.id)
  end

  def show
    add_breadcrumb t('order')
    @page_title = t('order_info')
    @order = Order.find params[:id]
  end

  def new

    # Create new order
    @order = Order.new

    # If have login user - init order with login user data
    if !@user.nil?
      @order.gender_id = @user.gender_id
      @order.first_name = @user.first_name
      @order.last_name = @user.last_name
      @order.email = @user.email
      @order.phone = @user.phone
      @order.fax = @user.fax
      @order.country_id = @user.country_id
      @order.state_id = @user.state_id
      @order.city = @user.city
      @order.postal_code = @user.postal_code
      @order.address = @user.address
      @order.second_address = @user.second_address
    end

  end

  # POST /order
  # POST /order.json
  def create

    @order = Order.new(order_params)
    if @order.valid?
      total_quantity = 0
      shopping_cart.products.each do |product, quantity|

        order_product = OrderProduct.new
        order_product.product_id = product.id
        order_product.name = product.name
        order_product.price = product.price
        order_product.quantity = quantity

        @order.order_products << order_product

        total_quantity = total_quantity + quantity
      end

      # Set order status to 'Pending'
      @order.order_status = OrderStatus.find params[1]
      @order.quantity = total_quantity
      @order.total = shopping_cart.total_price
      @order.user = @user
      @order.ip = request.remote_ip

    end

    if @order.valid? && @order.save
      clear_shopping_cart
      redirect_to @order.paypal_url(order_path(@order))
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end

  def hook
    # Permit all paypal input params
    params.permit!

    #TODO - check payment status - https://www.paypal.com/us/webapps/helpcenter/helphub/article/?solutionId=FAQ2334
    paymentStatus = params[:payment_status]
    if paymentStatus.upcase != 'COMPLETED'

      # Find order and set status to 'Processing'
      @order = Order.find params[:invoice]
      @order.update_attribute :status, OrderStatus.find params[2]

      # Update payment data
      @order.update_attribute :payment_status, paymentStatus
      @order.update_attribute :payment_transaction_id, params[:txn_id]
      @order.update_attribute :payment_method, params[:txn_type]
      @order.update_attribute :payment_date, Time.now

      # Update payer data
      @order.update_attribute :payer_id, params[:payer_id]
      @order.update_attribute :payer_first_name, params[:first_name]
      @order.update_attribute :payer_last_name, params[:last_name]
      @order.update_attribute :payer_country, params[:address_country]
      @order.update_attribute :payer_state, params[:address_state]
      @order.update_attribute :payer_address, params[:address_name]
      @order.update_attribute :payer_city, params[:address_city]
      @order.update_attribute :payer_postal_code, params[:address_zip]
      @order.update_attribute :payer_email, params[:payer_email]

      @order.save!
    end

    render nothing: true
  end

  def order_params
    params.require(:order).permit(:gender_id, :first_name, :last_name, :email, :phone, :fax, :country_id, :state_id, :city, :postal_code, :address, :second_address, :payment_method, :description)
  end

  private

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

  def init_user
    @user = user_signed_in? ? current_user : nil
  end

end
