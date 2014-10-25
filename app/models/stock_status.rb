class StockStatus < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name

  # Init class relationships
  has_many :products

end
