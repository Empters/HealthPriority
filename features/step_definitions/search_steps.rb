Given(/^we have product called "(.*?)"$/) do |arg1|
  @searched_name = arg1
  FactoryGirl.create(:product, :name => @searched_name)
end

When(/^Search by "(.*?)"$/) do |arg1|
  visit root_path
  within ".search-container" do
    fill_in "search_input", with: arg1
    click_on "search_link"
  end
end

Then(/^I have to see the My_Needed_Product$/) do
  expect(page).to have_content @searched_name.upcase
end
