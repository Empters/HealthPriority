class User < ActiveRecord::Base
  include ActiveModel::Validations

  # Validate required attributes
  validates_presence_of :gender_id, :first_name, :last_name, :email, :phone, :country_id, :state_id, :city, :postal_code, :address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments
  belongs_to :country
  belongs_to :state
end
