class HomeController < ApplicationController

  include Modules::SearchModule

  skip_before_filter :authenticate_user!
  before_action :set_breadcrumb
  before_action :set_web_store_detail, only: [:about_us, :contacts, :delivery_methods, :faq, :our_partners, :payment_methods, :rights_and_obligations, :license]

  include ApplicationHelper

  # GET index page
  def index

    # Init product list view parameters
    init_product_list_view(t('our_featured_products'), 8, 4, 'col-md-3 col-sm-4 col-xs-12')

    # Get best sellers
    @best_sellers = Product.where(is_best_seller: true)

    # Get last added products
    @products = Product.order(:created_at => :desc).paginate(:page => params[:page], :per_page => @products_per_page)

  end

  # GET about_us page
  def about_us
    add_breadcrumb t('about')

    @title = t('about')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.about_us.nil? ? '' : @web_store_detail.about_us.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  # GET contacts page
  def contacts
    add_breadcrumb t('contacts')

    @title = t('contacts')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.contact.nil? ? '' : @web_store_detail.contact.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/contacts'
      }
    end
  end

  # GET FAQ page
  def faq
    add_breadcrumb t('faq')

    @title = t('faq')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.faq.nil? ? '' : @web_store_detail.faq.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  # GET our_partners page
  def our_partners
    add_breadcrumb t('our_partners')

    @title = t('our_partners')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.partners.nil? ? '' : @web_store_detail.partners.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  # GET delivery_methods page
  def delivery_methods
    add_breadcrumb t('delivery_methods')

    @title = t('delivery_methods')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.delivery.nil? ? '' : @web_store_detail.delivery.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/delivery_methods'
      }
    end
  end

  # GET rights_and_obligations page
  def rights_and_obligations
    add_breadcrumb t('rights_and_obligations')

    @title = t('rights_and_obligations')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.rights_and_obligations.nil? ? '' : @web_store_detail.rights_and_obligations.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/rights_and_obligations'
      }
    end
  end

  # GET rights_and_obligations page
  def license
    add_breadcrumb t('license')

    @title = t('license')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.license.nil? ? '' : @web_store_detail.license.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/license'
      }
    end
  end

  # GET delivery_methods page
  def payment_methods
    add_breadcrumb t('payment_methods')

    @title = t('payment_mehtods')
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.payment_methods.nil? ? '' : @web_store_detail.payment_methods.html_safe
            end

    respond_to do |format|
      format.html {
        render 'home/payment_methods'
      }
    end
  end

  # GET help_center page
  def help_center
    respond_to do |format|
      format.html {
        render 'home/help_center'
      }
    end
  end

  # GET price_details page
  def price_details
    respond_to do |format|
      format.html {
        render 'home/price_details'
      }
    end
  end

  def send_message
    # Try to send email message
    mail = UserMailer.send_message(params[:name], params[:email], 'HP message', params[:message], params[:phone])

    mail.deliver

    # Display success message
    flash[:success] = t('message_successful')
    # binding.pry
    # Return to call page
    redirect_to(:back)

  end

  def update_states
    @states = params[:country_id].nil? ? nil : State.where(country_id: params[:country_id])
    respond_to do |format|
      format.js {
        render 'home/update_state'
      }
    end
  end

  private

  def set_web_store_detail
    @web_store_detail = WebStoreDetail.first
  end

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

end
