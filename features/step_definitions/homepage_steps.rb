require 'factory_girl'

Given(/^we have (\d+) products$/) do |arg1|
  # binding.pry
  FactoryGirl.create(:product, :name=> 'test')
end

When(/^I visit the homepage$/) do
  visit root_path
  # http://127.0.0.1:63001/
end

Then(/^I have to see the products$/) do
  expect(page).to have_content 'TEST'
end