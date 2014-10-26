ActiveAdmin.register Manufacturer do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 2

  # Set permit parameters
  permit_params :name, :image, :description, :sort_order, :remove_image

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
  form :html => {:multipart => true} do |f|
    f.inputs 'Manufacturer' do
      f.input :name
      f.input :image, :as => :file, :required => false, :hint => f.object.image.present? ? image_tag(f.object.image.url(:thumb)) : ''
      if (f.object.image.present?)
        f.input :remove_image, :as=> :boolean, :required => false, :label => 'Remove image'
      end
      f.input :description
      f.input :sort_order
    end
    f.actions
  end

end
