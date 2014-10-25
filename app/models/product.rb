class Product < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :quantity, :price, :active, :manufacturer_id, :sort_order, :stock_status_id

  # Init image file - paperclip image
  has_attached_file :image, :styles => { :thumb => '48x48' }

  # Explicitly do not validate attached image
  do_not_validate_attachment_file_type :image

  # Init product relationships
  belongs_to :manufacturer
  has_many :product_images
  has_many :product_reviews
  has_many :product_discounts
  has_and_belongs_to_many :categories
  has_one :stock_status

end
