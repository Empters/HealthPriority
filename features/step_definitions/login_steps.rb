Given(/^we have a user$/) do
  @user = User.where(:email => 'invisi@abv.bg')
end

  When(/^login with this user$/) do
    visit root_path
    click_link("Sign In")
    fill_in "user_email", with: "invisi@abv.bg"
    fill_in "user_password", with: "12345678"
    # binding.pry
    click_on("Log in")
  end

  Then(/^login is successful$/) do
    expect(page).to have_content "Signed in successfully"
  end

  Given(/^we are already logged in$/) do
    # expect(page).to have_content "Signed in successfully."
  end

  And(/^we click sign out$/) do
    click_link("Logout")
  end

  Then(/^logout is successful$/) do
    expect(page).to have_content "Signed out successfully."
  end