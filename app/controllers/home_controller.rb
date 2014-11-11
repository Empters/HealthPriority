class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_products, :set_pages, :set_from_controller

  def change_page
    puts request.headers
    $products = Product.paginate(:page => params[:page_number], :per_page => 6)
    @pages.each do |p, index|

      if p.number == params[:page_number].to_i
        p.is_active = true
      else
        p.is_active = false
      end
    end

    respond_to do |format|
      format.js { render 'products/search.js.erb' }
    end
  end

  private
    def set_products
      $products ||= Product.paginate(:page => params[:page], :per_page => 6)
    end

    def set_pages
      count = $products.count / 6
      diff = $products.count % 6
      count = count + 1 if diff > 0
      @pages = []
      count.times do |n|
        @pages <<  Page.new(n+1)
        @pages[0].is_active = true
      end

      @current_page = 1
    end

    def set_from_controller
      @from_controller = 'home'
    end
end
