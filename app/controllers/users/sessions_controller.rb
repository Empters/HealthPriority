class Users::SessionsController < Devise::SessionsController

  before_action :set_breadcrumb

  # GET /resource/sign_in
  def new
    add_breadcrumb t('login')
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def after_sign_in_path_for(resource)
    root_path(resource)
  end

  # def auth_options
  #   { :scope => resource_name, :redirect => "home#index" }
  # end

  private

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

end
