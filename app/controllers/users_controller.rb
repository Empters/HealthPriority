class UsersController < ApplicationController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_filter :authenticate_user!
  before_action :load_user
  before_action :set_breadcrumb

  def index
    puts 'index'
  end


  # GET /products/1
  # GET /products/1.json
  def show
    add_breadcrumb t('account')

    @title = 'My Account'
  end

  # GET /products/new
  def new
  end

  # GET /products/1/edit
  def edit
    # binding.pry
  end

  # POST /products
  # POST /products.json
  def create
    # binding.pry
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @user = current_user
    # binding.pry
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
  end

  def load_user
    @user ||= current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :gender_id, :first_name, :last_name, :phone, :fax, :country_id, :state_id, :city, :postal_code, :address, :second_address)
  end

  def set_breadcrumb
    add_breadcrumb t('home'), :root_path
  end
end
