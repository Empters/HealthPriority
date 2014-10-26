class Manufacturer < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name

  # Init image file - paperclip image
  has_attached_file :image, :styles => Rails.application.config.paperclip_styles

  # Validate content type
  validates_attachment_content_type :image, :content_type => Rails.application.config.paperclip_allow_image_content, :message => Rails.application.config.paperclip_allow_image_content_message

  # Init class relationships
  has_many :products

  # Remove image attribute
  attr_writer :remove_image

  # Remove image methods
  def remove_image
    @remove_image || false
  end

  # Remove image validation
  before_validation { self.image.clear if self.remove_image == '1' }

end
