ActiveAdmin.register ProductReview do

  # Set item menu position
  menu :parent => 'Catalog', :priority => 5

  # Set permit parameters
  permit_params :product_id, :text, :status

end
