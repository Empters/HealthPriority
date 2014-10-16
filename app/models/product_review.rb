class ProductReview < ActiveRecord::Base
  validates_presence_of :product_id, :status, :text

  belongs_to :product
end
