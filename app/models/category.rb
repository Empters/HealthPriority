class Category < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :active

  # Init image file - paperclip image
  has_attached_file :image,
                    :styles => Rails.application.config.paperclip_styles,
                    :default_url => '/missing_:style.png'

  # Validate content type
  validates_attachment_content_type :image, :content_type => Rails.application.config.paperclip_allow_image_content, :message => Rails.application.config.paperclip_allow_image_content_message

  # Init category recursive relationships - parent and child categories
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'

  # Init category relationships
  has_and_belongs_to_many :products, class_name: 'Product', join_table: 'products_categories'

  # Get for top category level
  scope :top_level, -> do
    where(parent: nil).order(:sort_order)
  end

  # Remove image attribute
  attr_writer :remove_image

  # Remove image methods
  def remove_image
    @remove_image || false
  end

  # Remove image validation
  before_validation { self.image.clear if self.remove_image == '1' }

  def parent_names
    @parent_names ||= get_ancestors(self).reverse.join(' > ')
  end

  def full_name
    @full_name ||= parent_names.empty? ? self.name : parent_names << ' > ' << self.name
  end

  def products_count
    @products_count ||= get_products_count(self)
  end

  def get_ancestors(who)
    @tree ||= []
    if who.parent.nil?
      return @tree
    else
      @tree << who.parent.name
      get_ancestors(who.parent)
    end
  end

  def get_products_count(who)
    count = who.products.count
    if !who.children.nil? && who.children.count > 0
      who.children.each do |child|
        count += get_products_count(child)
      end
    end

    return count
  end

end
