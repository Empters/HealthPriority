require 'factory_girl'

  Given(/^I have (\d+) products$/) do |arg1|
    arg1.to_i.times do
      FactoryGirl.create(:product)
    end
  end