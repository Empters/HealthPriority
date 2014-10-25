ActiveAdmin.register StockStatus do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 4

  # Set permit parameters
  permit_params :stock_status_id, :name

end
