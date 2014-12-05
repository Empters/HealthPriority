class ShoppingCart

  # Shop cart products hash getter
  def products
    @products ||= Hash.new
  end

  # Add/Remove products to cart - remove if set quantity with negative value
  def add_product_to_cart(product, quantity)

    # Calculate product count
    last_quantity = products.has_key?(product) ? products[product].to_i() : 0
    product_quantity = last_quantity + quantity

    # Check if
    if product_quantity > 0
      # Change product count
      products[product] = last_quantity + quantity
    else
      # Remove product
      remove_product_from_cart(product)
    end

  end

  # Remove product from cart
  def remove_product_from_cart(product)
    products.delete(product)
  end

  # Get total products count
  def total_products_count

    # Init default value
    total_products_count = 0

    # Calculate products count
    if !products.empty?
      products.each {|key, value| total_products_count = total_products_count + value }
    end

    @total_products_count = total_products_count
  end

  # Shop cart total price getter
  def total_price

    # Init default value
    total_price = 0

    # Calculate products count
    if !products.empty?
      products.each {|key, value| total_price = total_price + (key.price * value) }
    end

    @total_price = total_price
  end

end