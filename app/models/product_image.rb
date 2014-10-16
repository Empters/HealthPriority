class ProductImage < ActiveRecord::Base
  validates_presence_of :product_id, :image

  belongs_to :product
end
