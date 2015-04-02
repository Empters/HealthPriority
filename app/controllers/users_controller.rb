class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_action :init_user, :set_breadcrumb

  # GET /products/1
  # GET /products/1.json
  def show
    add_breadcrumb t('my_account')
  end

  # GET /products/new
  def new
  end

  # GET /products/1/edit
  def edit
    add_breadcrumb t('my_account'), user_path(@user)
    add_breadcrumb t('edit_profile')
  end

  # POST /products
  # POST /products.json
  def create
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('update_user_successful_message') }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
  end

  private

  def init_user
    @user ||= current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :gender_id, :first_name, :last_name, :phone, :fax, :country_id, :state_id, :city, :postal_code, :address, :second_address)
  end

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

end
