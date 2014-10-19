ActiveAdmin.register Product do

  permit_params :name, :price, :manufacturer_id, :status, :sort_order

  index do
    selectable_column
    column 'Name' do |post|
      link_to post.name, admin_product_path(post)
    end
    column :manufacturer
    column :quantity
    column :price
    column :status
    column :create_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :create_at, :as => :ui
      f.input :model
      f.input :manufacturer_id, :as => :select, collection: Manufacturer.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose manufacturer'
      f.input :quantity
      f.input :price
      f.input :image
      f.input :description
      f.input :status, :as => :radio, :collection => [['Active', 1, {:checked => true}], ['Disable', 0]]
      f.input :sort_order
      f.input :date_available
      f.input :meta_keyword
      f.input :meta_description

    end
    f.actions
  end

end
