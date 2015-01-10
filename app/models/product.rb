class Product < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :quantity, :price, :active, :manufacturer_id, :sort_order, :stock_status_id

  # Init image file - paperclip image
  has_attached_file :image,
                    :styles => Rails.application.config.paperclip_styles,
                    :default_url => '/missing_:style.png'

  # Validate content type
  validates_attachment_content_type :image, :content_type => Rails.application.config.paperclip_allow_image_content, :message => Rails.application.config.paperclip_allow_image_content_message

  # Init product relationships
  belongs_to :manufacturer
  belongs_to :stock_status

  # Has many relations
  has_many :product_images, :dependent => :destroy, :autosave => true
  has_many :product_reviews
  has_many :product_discounts

  # Category relations
  has_and_belongs_to_many :categories, :autosave => true, class_name: 'Category', join_table: 'products_categories'

  # Related products relation
  has_and_belongs_to_many :related_products, :autosave => true, class_name: 'Product', join_table: 'product_related', foreign_key: 'related_id'

  # Edit product categories
  accepts_nested_attributes_for :related_products, allow_destroy: true,
                                :reject_if => lambda { |attributes| attributes[:product_id].blank? }

  # Edit product categories
  accepts_nested_attributes_for :categories, allow_destroy: true,
                                :reject_if => lambda { |attributes| attributes[:category_id].blank? }
  # Edit product images
  accepts_nested_attributes_for :product_images, allow_destroy: true,
                                :reject_if => lambda { |attributes| attributes[:image].blank? }

  scope :feature_products, -> do
    order('created_at desc').limit(18)
  end

  scope :last_visit_products, -> do
    order('created_at desc').limit(4)
  end

  # Remove image attribute
  attr_writer :remove_image

  def isInStock?
    stock_status_id > 0
  end

  # Remove image methods
  def remove_image
    @remove_image || false
  end

  def average_rating
    begin
      (product_reviews.map{|x| x.rating}.inject(:+) / product_reviews.size).round
    rescue
      0
    end
  end

  # Remove image validation
  before_validation { self.image.clear if self.remove_image == '1' }

  def eql?(other_product)
    self.id == other_product.id
  end

  def hash
    id.hash
  end

end
