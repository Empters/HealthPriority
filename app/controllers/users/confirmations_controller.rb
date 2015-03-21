class Users::ConfirmationsController < Devise::ConfirmationsController

  before_action :set_breadcrumb

  # GET /resource/confirmation/new
  def new
    add_breadcrumb t('resend_instr')
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    root_path(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    root_path(resource_name)
  end

  private

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

end
