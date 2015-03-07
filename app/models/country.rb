class Country < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :iso

  # Has many relations
  has_many :states

end
