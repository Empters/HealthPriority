module Modules
  module SearchModule

    def search_params
      params.permit(:page, :token, :format, :category, :brand, :range)
    end

    # TODO - create multi filter method
    def search_and_filter()

      if (!@range.blank?)
        @products = Product.where(price: @price_ranges[@range.to_i][0] .. @price_ranges[@range.to_i][1]);
      elsif (!@brand.blank?)
        @products = Product.where('manufacturer_id' => @brand)
      elsif (@token.blank? && @category.blank?)
        @products ||= Product.all
      elsif @category.blank?
        @products = Product.where('UPPER(name) LIKE :name or UPPER(description) LIKE :name ', {:name => "%#{@token.upcase}%"})
      else
        @categoryObj = Category.find(@category)
        if @token.blank?
          if (@categoryObj.parent)
            @products = Product.joins(products_categories: :category).where(categories: {id: @categoryObj})
          else
            @products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                            {:category => @categoryObj})
          end
        else
          if (@categoryObj.parent)
            @products = Product.joins(products_categories: :category).where(categories: {id: @categoryObj}).where('UPPER(products.name) LIKE :token', {token: '%' + @token.upcase + '%'})
          else
            @products = Product.joins(products_categories: :category).where('(categories.id = :category or categories.parent_id = :category)',
                                                                            {:category => @categoryObj}).where('UPPER(products.name) LIKE :token', {token: '%' + @token.upcase + '%'})
          end
        end
      end
    end

    def set_search_and_filter_params
      @token = search_params[:token]
      @category = search_params[:category]
      @brand = search_params[:brand]
      @range = search_params[:range]
    end

  end
end