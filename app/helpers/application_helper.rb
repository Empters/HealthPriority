module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-error'
      when 'alert'
        'alert-block'
      when 'notice'
        'alert-info'
      else
        flash_type.to_s
    end
  end

  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  def submit_or_cancel(form, name='Cancel')
    form.submit + ' or ' +  link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Lazy loading init root categories
  def init_root_categories
    @root_categories ||= Category.top_level
  end

  # Get last visit products by user
  def last_visit_products
    session[:last_visit_products] ||= Product.last_visit_products.to_a()
    @last_visit_products = session[:last_visit_products]
  end

  # Add to user last visit product collection
  def add_to_last_visit_product(product)
    # Check input parameters
    if product.nil?
      return
    end

    # Change last visit products
    last_visit_products = session[:last_visit_products]
    if last_visit_products.nil?
      last_visit_products = Array.new
      last_visit_products << product
    else
      if last_visit_products.include?(product)
        index = last_visit_products.index(product)
        last_visit_products.insert(0, last_visit_products.delete_at(index))
      else
        if last_visit_products.length > 3
          last_visit_products.delete_at(last_visit_products.length - 1)
        end
        last_visit_products.unshift(product)
      end
    end
    session[:last_visit_products] = last_visit_products
  end

  # Get shopping cart
  def shopping_cart
    session[:shopping_cart] ||= ShoppingCart.new()
    @shopping_cart = session[:shopping_cart]
  end

  def clear_shopping_cart
    session[:shopping_cart] = ShoppingCart.new()
    @shopping_cart = session[:shopping_cart]
  end

  # Add product to shopping cart
  def add_to_shopping_cart(product, quantity)
    shopping_cart.add_product_to_cart(product, quantity)
  end

  def set_page_title(title)
    @page_name = title
  end
end
