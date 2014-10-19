class Product < ActiveRecord::Base
  validates_presence_of :name, :quantity, :price, :status, :manufacturer_id, :sort_order

  belongs_to :manufacturer

  has_many :product_images
  has_many :product_reviews
  has_many :product_discounts

  has_and_belongs_to_many :categories

end
