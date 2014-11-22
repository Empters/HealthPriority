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

    def paginate_products
      $products = $products.paginate(:page => @current_page, :per_page => 6)
    end

    def main_change_page
      @current_page = search_params[:page_number].to_i
      $products = $products.paginate(:page => @current_page, :per_page => 6)
      @pages.each { |p| p.is_active=false }
      @pages[@current_page-1].is_active=true
    end

    def search_params
      params.permit(:token, :format, :category, :page_number)
    end

    def search_and_filter(category, token)
      if (!token && !category)
        $products ||= Product.all
      elsif !category
        $products = Product.where("UPPER(name) LIKE :name", {:name => "%" + token.upcase + "%"})
      elsif !token
        @category = Category.find(search_params[:category])
        if (@category.parent)
          $products = Product.joins(products_categories: :category).where(categories: {id: @category})
        else
          $products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                          {:category => @category})
        end
      else
        @category = Category.find(search_params[:category])
        if (@category.parent)
          $products = Product.joins(products_categories: :category).where(categories: {id: @category}).where('UPPER(products.name) LIKE :token', {token: "%" + token.upcase + "%"})
        else
          $products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                          {:category => @category}).where('UPPER(products.name) LIKE :token', {token: "%" + token.upcase + "%"})
        end
      end
    end
  end
end