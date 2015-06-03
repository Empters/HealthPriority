module Modules
  module SearchModule

    def search_params
      params.permit(:page, :token, :format, :category, :brand, :range)
    end

    # TODO - create multi filter method
    def search_and_filter()

      category = session[:category]
      token = session[:token]

      if (session[:range])
        @products = Product.where(price: @price_ranges[session[:range].to_i][0] .. @price_ranges[session[:range].to_i][1]);
      elsif (session[:brand])
        @products = Product.where('manufacturer_id' => session[:brand])
      elsif (!token && !category)
        @products ||= Product.all
      elsif category.blank?
        @products = Product.where('UPPER(name) LIKE :name or UPPER(description) LIKE :name ', {:name => "%#{token.upcase}%"})
      elsif token.blank?
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
          @products = Product.joins(products_categories: :category).where(categories: {id: @category}).where('UPPER(products.name) LIKE :token', {token: '%' + token.upcase + '%'})
        else
          @products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                          {:category => @category}).where('UPPER(products.name) LIKE :token', {token: '%' + token.upcase + '%'})
        end
      end
    end

    def set_search_and_filter_params
      session[:token] = search_params[:token]
      session[:category] = search_params[:category]
      session[:brand] = search_params[:brand]
      session[:range] = search_params[:range]
    end

  end
end