class ProductReview < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :product_id, :status, :text

  # Init class relationships
  belongs_to :product

end
