class Product < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :quantity, :price, :active, :manufacturer_id, :sort_order, :stock_status_id

  # Init image file - paperclip image
  has_attached_file :image, :styles => { :thumb => '48x48' }, :allow_destroy => true

  # Validate content type
  validates_attachment_content_type :image, :content_type => /\Aimage/

  # Validate filename
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  # Init product relationships
  belongs_to :manufacturer
  belongs_to :stock_status

  has_many :product_images, :dependent => :destroy, :autosave => true
  has_many :product_reviews
  has_many :product_discounts

  has_and_belongs_to_many :categories, :autosave => true, class_name: 'Category', join_table: 'products_categories'

  accepts_nested_attributes_for :categories, allow_destroy: true,
                                :reject_if => lambda { |attributes| attributes[:category_id].blank? }
  accepts_nested_attributes_for :product_images, allow_destroy: true,
                                :reject_if => lambda { |attributes| attributes[:image].blank? }

end
