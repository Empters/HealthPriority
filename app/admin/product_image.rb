ActiveAdmin.register ProductImage do

  permit_params :product_id, :image, :sort_order

end
