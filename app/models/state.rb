class State < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :iso, :country_id

  # Init class relationships
  belongs_to :country

end
