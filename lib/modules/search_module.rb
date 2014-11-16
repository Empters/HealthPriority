module Modules
  module SearchModule
    def set_products
      $products = Product.paginate(:page => params[:page], :per_page => 6)
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

    def main_change_page
      @current_page = search_params[:page_number].to_i
      $products = Product.paginate(:page => @current_page, :per_page => 6)
      @pages.each { |p| p.is_active=false }
      @pages[@current_page-1].is_active=true
    end

    def search_params
      params.permit(:token, :format, :category, :page_number)
    end
  end
end