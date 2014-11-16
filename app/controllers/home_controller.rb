class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products, :set_pages, :set_from_controller

  include Modules::SearchModule

  def change_page
    main_change_page
    respond_to do |format|
      format.js { render 'products/search.js.erb' }
    end
  end

  def index
    #TODO - check if have by ip
    $last_visit_products ||= Product.last_visit_products.to_a()
  end
end
