class ProductDiscount < ActiveRecord::Base
  validates_presence_of :product_id, :price, :quantity

  belongs_to :product
end
