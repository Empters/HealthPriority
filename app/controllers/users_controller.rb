class UsersController < ApplicationController

# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_filter :authenticate_user!
  before_action :set_breadcrumb
  before_action :init_user, :set_breadcrumb
  before_action :init_params, only: :edit

  def index
    puts 'index'
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @title = 'My Account'
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
      inserted_params = user_params
      inserted_params[:state_id] = 0 unless inserted_params[:state_id] != ''

      if @user.update(inserted_params)
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

  def init_params
    @countries = Country.all
    @genders = Gender.all

    # binding.pry
    if @user.country.nil?
      @states = State.all
    else
      @states = State.where(:country_id => @user.country.id)
    end
  end
end