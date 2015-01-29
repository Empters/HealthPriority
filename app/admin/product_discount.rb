ActiveAdmin.register ProductDiscount do

  # Set item menu position
  menu :parent => 'Sales', :priority => 5

  # Set permit parameters
  permit_params :product_id, :customer_group_id, :quantity, :priority, :price, :date_start, :date_end

  # Init filters
  filter :product_id
  filter :priority
  filter :quantity
  filter :price
  filter :date_start
  filter :date_end

  # Init index page
  index do
    selectable_column
    column 'Product' do |post|
      link_to post.product.name, admin_product_path(post.product)
    end
=begin
    column :customer_group_id
=end
    column :quantity
    column :price
    column :date_start
    column :date_end
    column :priority
    actions
  end

  # Init edit page
  form do |f|
    f.inputs 'Category' do
      f.input :product_id, :as => :select, collection: Product.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose product'
      f.input :price
      f.input :quantity
      f.input :date_start, :as => :date_picker
      f.input :date_end, :as => :date_picker
      f.input :priority
    end
    f.actions
  end

end
