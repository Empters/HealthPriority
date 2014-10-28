require 'factory_girl'

Given(/^we have (\d+) products$/) do |arg1|
  # binding.pry
  arg1.to_i.times do
    FactoryGirl.create(:product)
  end
end

When(/^I visit the homepage$/) do
  visit root_path
  # http://127.0.0.1:63001/
end

Then(/^I have to see the products$/) do
  expect(page).to have_content 'PRODUCT'
end