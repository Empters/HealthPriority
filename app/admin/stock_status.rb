ActiveAdmin.register StockStatus do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 3

  # Set permit parameters
  permit_params :name

  # Init filters
  filter :name
  filter :created_at
  filter :updated_at

  # Init index page
  index do
    selectable_column
    column 'Name' do |post|
      link_to post.name, admin_stock_status_path(post)
    end
    column :created_at
    column :updated_at
    actions
  end

end
