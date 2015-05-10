class User < ActiveRecord::Base
  include ActiveModel::Validations

  # Validate required attributes
  validates_presence_of :gender_id, :first_name, :last_name, :email, :phone, :country_id, :state_id, :city, :postal_code, :address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  has_one :country
  has_one :state

  def full_name
    "#{first_name} #{last_name}"
  end

end
