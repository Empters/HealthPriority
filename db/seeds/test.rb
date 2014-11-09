require 'factory_girl'

FactoryGirl.create(:user)
6.times do
  FactoryGirl.create(:category, is_top?: true)
end

6.times do
  FactoryGirl.create(:product)
end

FactoryGirl.create(:web_store_detail)
