class Manufacturer < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name

  # Init image file - paperclip image
  has_attached_file :image, :styles => { :thumb => '48x48' }

  # Explicitly do not validate attached image
  do_not_validate_attachment_file_type :image

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
