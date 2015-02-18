module Modules
  module SearchModule
    def set_products
      @products = Product.paginate(:page => params[:page], :per_page => session[:products_per_page])
    end

    def set_pages
      count = @products.count / session[:products_per_page]
      diff = @products.count % session[:products_per_page]
      count = count + 1 if diff > 0
      @pages = []
      count.times do |n|
        @pages <<  Page.new(n+1)
        @pages[0].is_active = true
      end
      @current_page = 1
    end

    def paginate_products
      @products = @products.paginate(:page => @current_page, :per_page => session[:products_per_page])
    end

    def main_change_page
      @current_page = session[:page_number]
      @pages.each { |p| p.is_active=false }
      @pages[@current_page-1].is_active=true
      paginate_products
    end

    def search_params
      params.permit(:token, :format, :category, :page_number, :brand, :range)
    end

    def search_and_filter()

      category = session[:category]
      token = session[:token]


      if(session[:range])
        @products = Product.where(price: @price_ranges[session[:range].to_i][0] .. @price_ranges[session[:range].to_i][1]);
      elsif(session[:brand])
        @products = Product.where('manufacturer_id'=>session[:brand])
      elsif (!token && !category)
        @products ||= Product.all
      elsif !category
        @products = Product.where("UPPER(name) LIKE :name", {:name => "%" + token.upcase + "%"})
      elsif !token
        @category = Category.find(category)
        if (@category.parent)
          @products = Product.joins(products_categories: :category).where(categories: {id: @category})
        else
          @products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                          {:category => @category})
        end
      else
        @category = Category.find(search_params[:category])
        if (@category.parent)
          @products = Product.joins(products_categories: :category).where(categories: {id: @category}).where('UPPER(products.name) LIKE :token', {token: "%" + token.upcase + "%"})
        else
          @products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                          {:category => @category}).where('UPPER(products.name) LIKE :token', {token: "%" + token.upcase + "%"})
        end
      end
    end

    def filter_by_manufacturer
      @manufacturer = session[:brand];
      @products = Product.where('manufacturer_id'=>@manufacturer)
    end

    def filter_by_price
      # binding.pry
      @products = Product.where(price: @price_ranges[session[:range].to_i][0].to_i .. @price_ranges[session[:range].to_i][1].to_i);
    end

    def set_search_and_filter_params
      session[:category] = search_params[:category]
      session[:token] = search_params[:token]
      session[:brand] = search_params[:brand]
      session[:range] = search_params[:range]
    end

    def product_passed
      diff = @current_page * session[:products_per_page] - @products.count

      if diff <=  0
        @current_page * session[:products_per_page]
      else
        (@current_page - 1)*session[:products_per_page] + (session[:products_per_page] - diff)
      end
    end
  end
end