ActiveAdmin.register ProductReview do

  permit_params :product_id, :text, :status

end
