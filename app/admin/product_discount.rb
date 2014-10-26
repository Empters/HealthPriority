ActiveAdmin.register ProductDiscount do

  # Set item menu position
  menu :parent => 'Sales', :priority => 5

  # Set permit parameters
  permit_params :product_id, :customer_group_id, :quantity, :priority, :price, :date_start, :date_end

  # Init index page
  index do
    selectable_column
    column :product_id
    column :customer_group_id
    column :priority
    column :quantity
    column :price
    column :date_start
    column :date_end
    actions
  end

  # Init edit page
  form do |f|
    f.inputs 'Category' do
      f.input :product_id, :as => :select, collection: Product.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose product'
      f.input :quantity
      f.input :price
      f.input :priority
      f.input :date_start, :as => :date_picker
      f.input :date_end, :as => :date_picker
    end
    f.actions
  end

end
