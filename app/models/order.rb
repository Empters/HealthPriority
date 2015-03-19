class Order < ActiveRecord::Base
  belongs_to :payment
end
