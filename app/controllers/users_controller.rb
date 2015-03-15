class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_action :init_user, :set_breadcrumb

  def index
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
  end

  # GET /products/1/edit
  def edit
    add_breadcrumb t('Account')
    add_breadcrumb t('edit')
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
