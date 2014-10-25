ActiveAdmin.register Manufacturer do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 2

  # Set permit parameters
  permit_params :name, :image, :description, :sort_order

  # Init filters
  filter :name
  filter :description

  # Init index page
  index do
    selectable_column
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column 'Name' do |post|
      link_to post.name, admin_manufacturer_path(post)
    end
    column :sort_order
    actions
  end

  # Init edit page
  form do |f|
    f.inputs 'Manufacturer' do
      f.input :name
      f.input :image, :as => :file, :required => false, :hint => f.template.image_tag(f.object.image.url(:thumb))
      f.input :description
      f.input :sort_order
    end
    f.actions
  end

end
