class ProductImage < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :product_id

  # Init image file - paperclip image
  has_attached_file :image, :styles => { :thumb => '48x48' }

  # Explicitly do not validate attached image
  do_not_validate_attachment_file_type :image

  # Init class relationships
  belongs_to :product

end
