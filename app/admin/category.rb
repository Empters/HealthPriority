ActiveAdmin.register Category do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 1

  # Set permit parameters
  permit_params :name, :description, :image, :active, :sort_order, :meta_keyword, :meta_description, :parent_id

  # Init filters
  filter :parent_id
  filter :name
  filter :description
  filter :active
  filter :meta_keyword
  filter :meta_description

  # Init index page
  index do
    selectable_column
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column 'Name' do |post|
      link_to post.name, admin_category_path(post)
    end
=begin
    column 'Parent' do |post|
      link_to post.parent, admin_category_path(post.parent)
    end
=end
    column :description, :as => :rich
    column :active
    column :sort_order
    column :meta_keyword
    column :meta_description
    actions
  end

  # Init edit page
  form do |f|
    f.inputs 'Category' do
      f.input :name
      f.input :parent_id, :as => :select, collection: Category.where.not(id: f.object.id), :member_label => :name, :member_value => :id, :include_blank => 'Choose category'
      f.input :description
      f.input :image, :as => :file, :required => false, :hint => f.template.image_tag(f.object.image.url(:thumb))
      f.input :active
      f.input :sort_order
      f.input :meta_keyword
      f.input :meta_description
    end
    f.actions
  end

end
