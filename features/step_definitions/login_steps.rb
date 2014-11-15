Given(/^I have a user with email "([^\"]*)" and password "([^\"]*)"$/) do |email, password|
  @user = User.find_by_email(email)
  if @user.nil?
    @user = FactoryGirl.create(:user, :email => email, :password => password)
  else
    @user.update(:password => password)
  end
end