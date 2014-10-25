ActiveAdmin.register Product do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 3

  # Set permit parameters
  permit_params :name, :quantity, :viewed, :image, :price, :points, :description, :active, :manufacturer_id, :sort_order, :date_available, :meta_keyword, :meta_description, :stock_status_id

  # Init filters
  filter :name
  filter :price
  filter :quantity
  filter :manufacturer
  filter :active
  filter :meta_description

  # Init index page
  index do
    selectable_column
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column 'Name' do |post|
      link_to post.name, admin_product_path(post)
    end
    column :stock_status_id
    column :price
    column :quantity
    column :manufacturer
    column :active
    column :create_at
    column :updated_at
    actions
  end

  # Init edit page
  form do |f|
    f.inputs do
      f.input :name
      f.input :manufacturer_id, :as => :select, collection: Manufacturer.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose manufacturer'
      f.input :stock_status_id, :as => :select, collection: StockStatus.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose stock status'
      f.input :quantity
      f.input :price
      f.input :image, :as => :file, :required => false, :hint => f.template.image_tag(f.object.image.url(:thumb))
      f.input :description
      f.input :active
      f.input :sort_order
      f.input :date_available, :as => :date_picker
      f.input :meta_keyword
      f.input :meta_description
    end
    f.actions
  end

end
