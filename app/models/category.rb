class Category < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :active

  # Init image file - paperclip image
  has_attached_file :image, :styles => { :thumb => '48x48' }

  # Explicitly do not validate attached image
  do_not_validate_attachment_file_type :image

  # Init category recursive relationships - parent and child categories
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'

  # Init category relationships
  has_and_belongs_to_many :products

  # Get for top category level
  scope :top_level, where(:parent_id => nil)

end
