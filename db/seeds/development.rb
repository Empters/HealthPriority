require 'factory_girl'
# require 'spec/factories/user_factory'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# user = User.create :email => 'invisi@abv.bg', :password => '12345678', :confirmed_at => "2014-10-24 08:43:33", :confirmation_sent_at => "2014-10-24 08:43:20"

FactoryGirl.create(:user)

6.times do
  FactoryGirl.create(:category, is_top?: true)
end

6.times do
  @product = FactoryGirl.create(:product)
end