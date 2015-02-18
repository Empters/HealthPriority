class HomeController < ApplicationController

  include Modules::SearchModule

  skip_before_filter :authenticate_user!
  before_action :set_breadcrumb
  before_action :set_products_per_page, only: [:index, :change_page]
  before_action :set_from_controller, :set_best_sellers, :set_products, :set_pages, :set_search_and_filter_params, only: [:index, :change_page]
  before_action :set_web_store_detail, only: [:about_us, :contacts, :delivery_methods, :faq, :our_partners, :payment_methods]

  helper_method :product_passed

  # GET index page
  def index
  end

  # GET change_page
  def change_page
    session[:page_number] = search_params[:page_number].to_i

    @products = search_and_filter
    set_pages
    @products = main_change_page

    respond_to do |format|
      format.js { render 'products/search.js.erb' }
    end
  end

  # GET about_us page
  def about_us
    add_breadcrumb t('about')

    @title = 'About'
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

    @title = 'Contacts'
    @html = if @web_store_detail.nil? then
              ''
            else
              @web_store_detail.contact.nil? ? '' : @web_store_detail.contact.html_safe
            end
    @isContactView = true

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  # GET FAQ page
  def faq
    add_breadcrumb t('faq')

    @title = 'FAQ'
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

    @title = 'Our partners'
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


    @isDeliveryView = true

    respond_to do |format|
      format.html {
        render 'home/render_html'
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

    @isPaymentMethodsView = true

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  # GET help_center page
  def help_center
    add_breadcrumb t('help_center')

    @title = t('help_center')

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  # GET price_details page
  def price_details
    add_breadcrumb t('what_is_included_in_the_price')

    @title = t('what_is_included_in_the_price')

    respond_to do |format|
      format.html {
        render 'home/render_html'
      }
    end
  end

  def send_message
    # Try to send email message
    UserMailer.send_message(params[:name], params[:email], 'HP message', params[:message])

    # Display success message
    flash[:success] = t('message_successful')

    # Return to call page
    redirect_to(:back)
  end

  private

  def set_from_controller
    @from_controller = 'home'
    @page_label = t('our_featured_products')
  end

  def set_products_per_page
    session[:products_per_page] = 8
    @products_per_row = 4
    @table_css = 'col-md-3 col-sm-4 col-xs-12'
  end

  def set_best_sellers
    @best_sellers = Product.where(is_best_seller: true)
  end

  def set_web_store_detail
    @web_store_detail = WebStoreDetail.first
  end

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end
end
