class Users::PasswordsController < Devise::PasswordsController

  before_action :set_breadcrumb

  # GET /resource/password/new
  def new
    add_breadcrumb t('forgotten_pass')
    super
  end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    add_breadcrumb t('change_password')
    super
  end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected

  def after_resetting_password_path_for(resource)
    root_path(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path(resource_name)
  end

  private

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

end
