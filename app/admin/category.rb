ActiveAdmin.register Category do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 1

  # Set permit parameters
  permit_params :name, :description, :image, :active, :sort_order, :meta_keyword, :meta_description, :parent_id,
                :remove_image

  # Init filters
  filter :name
  filter :parent_id, :as => :select, collection: Category.all, :member_label => :name, :member_value => :id
  filter :active
  filter :created_at
  filter :updated_at

  # Init index page
  index do
    selectable_column
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column 'Name' do |post|
      link_to post.name, admin_category_path(post)
    end
    column :parent
    column :active
    column :sort_order
    column :created_at
    column :updated_at
    actions
  end

  # Init edit page
  form :html => {:multipart => true} do |f|
    f.inputs do
      f.input :name
      f.input :parent_id, :as => :select, collection: Category.where.not(id: f.object.id), :member_label => :name, :member_value => :id, :include_blank => 'Choose category'
      f.input :image, :as => :file, :required => false, :hint => f.object.image.present? ? image_tag(f.object.image.url(:thumb)) : ''
      if (f.object.image.present?)
        f.input :remove_image, :as => :boolean, :required => false, :label => 'Remove image'
      end
      f.input :description, :as => :ckeditor
      f.input :active
      f.input :sort_order
      f.input :meta_keyword
      f.input :meta_description
    end
    f.actions
  end

end
