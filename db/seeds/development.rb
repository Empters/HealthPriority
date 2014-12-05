require 'factory_girl'

FactoryGirl.create(:user)

14.times do
  FactoryGirl.create(:product)
end

FactoryGirl.create(:web_store_detail)
