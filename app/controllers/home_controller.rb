class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products, only: [:index]
  before_action :set_pages, :set_from_controller

  include Modules::SearchModule

  def change_page
    main_change_page
    respond_to do |format|
      format.js { render 'products/search.js.erb' }
    end
  end

  def index
  end

  private
    def set_from_controller
      @from_controller = 'home'
    end
end
