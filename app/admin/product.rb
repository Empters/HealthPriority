ActiveAdmin.register Product do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 4

  # Set permit parameters
  permit_params :name, :quantity, :viewed, :image, :price, :points, :description, :active, :manufacturer_id, :sort_order,
                :date_available, :meta_keyword, :meta_description, :stock_status_id, product_images_ids:[], categories_ids:[]

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
    column :created_at
    column :updated_at
    actions
  end

  # Init edit page
  form :html => {:multipart => true} do |f|
    f.inputs do
      f.input :name
      f.input :categories, :as => :check_boxes, :multiple => true
      f.input :manufacturer_id, :as => :select, collection: Manufacturer.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose manufacturer'
      f.input :stock_status_id, :as => :select, collection: StockStatus.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose stock status'
      f.input :quantity
      f.input :price
      f.input :image, :as => :file, :required => false, :hint => image_tag(f.object.image.url(:thumb))
      f.input :description
      f.input :active
      f.input :sort_order
      f.input :date_available, :as => :date_picker
      f.input :meta_keyword
      f.input :meta_description
      f.inputs 'Product images' do
        f.has_many :product_images do |images|
          images.inputs :html => {:multipart => true} do
            images.input :image, as: :file, :required => true, hint: image_tag(images.object.image.url(:thumb))
          end
        end
      end
    end
    f.actions
  end

=begin
  controller do
    def update
      post = Post.find(params[:id])
      post.categories.delete_all
      categories = params[:post][:category_ids]
      categories.shift
      categories.each do |category_id|
        post.categories << Category.find(category_id.to_i)
      end
      redirect_to resource_path(post)
    end
  end
=end

end
