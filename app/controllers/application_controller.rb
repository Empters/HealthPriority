class ApplicationController < ActionController::Base

  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :init_root_categories, :init_user

  after_filter :flash_to_headers

  @page_name = ''

=begin
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
=end

  private

  ALLOW_MESSAGE_TYPES = ['error', 'warning', 'success', 'notice']

  def flash_to_headers
    if request.xhr? && !flash.empty?
      response.headers['X-Message'] = flash_message
      response.headers['X-Message-Type'] = flash_type.to_s
      flash.discard
    end
  end

  def flash_message
    ALLOW_MESSAGE_TYPES.each do |type|
      if flash.key?(type) && !flash[type].blank?
        return flash[type]
      end
    end

    return nil
  end

  def flash_type
    ALLOW_MESSAGE_TYPES.each do |type|
      if flash.key?(type) && !flash[type].blank?
        return type
      end
    end

    return nil
  end

  def init_user
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end
end
