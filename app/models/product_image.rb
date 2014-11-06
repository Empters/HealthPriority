class ProductImage < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :product_id

  # Init image file - paperclip image
  has_attached_file :image,
                    :styles => Rails.application.config.paperclip_styles,
                    :default_url => '/missing_:style.png'

  # Validate content type
  validates_attachment_content_type :image, :content_type => Rails.application.config.paperclip_allow_image_content, :message => Rails.application.config.paperclip_allow_image_content_message

  # Init class relationships
  belongs_to :product

end
