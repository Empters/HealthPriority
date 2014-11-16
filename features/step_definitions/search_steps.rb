Given(/^I have product called "([^\"]*)" with category "([^\"]*)"$/) do |productName, categoryName|
  @category = Category.find_by_name(categoryName)
  if @category.nil?
    @category = FactoryGirl.create(:category, :name => categoryName)
  end

  @product = FactoryGirl.create(:product, :name => productName, :categories => [@category])
end