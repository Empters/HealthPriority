Given(/^we have product called "(.*?)"$/) do |arg1|
  @searched_name = arg1
  @product = FactoryGirl.create(:product, :name => @searched_name)
end