Given(/^we have product called "(.*?)"$/) do |arg1|
  @searched_name = arg1
  @product = FactoryGirl.create(:product, :name => @searched_name)
end

When(/^Search by "(.*?)"$/) do |arg1|
  visit root_path
  within ".search-container" do
    fill_in "search_input", with: arg1
    find("#search_link").click
  end
end

Then(/^I have to see the product$/) do
  expect(page).to have_content @searched_name.upcase
end

When(/^Click on the category of created product$/) do
  @category = @product.categories.first;
  if(@category.parent)
    @first_level_category_name = @category.name[0, @category.name.rindex('_')];
    find('div[data-category='+ @first_level_category_name.to_s + ']').click
  end
  click_on @category.name
end