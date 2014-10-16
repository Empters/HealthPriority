class Category < ActiveRecord::Base
  validates_presence_of :name, :status

  has_and_belongs_to_many :products
end
