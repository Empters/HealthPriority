#encoding: utf-8
Feature: See if login works

  Scenario: Test user login
    Given I have a user with email "invisi@abv.bg" and password "12345678"
    And I am on the home page
    When I click "Login"
    And I fill in "invisi@abv.bg" for "user_email"
    And I fill in "12345678" for "user_password"
    And I press "Log in"
    Then I should see "USER PROFILE"
    And I should see "LOGOUT"

  Scenario: Test user log out
    Given I have a user with email "invisi@abv.bg" and password "12345678"
    And I am on the home page
    When I click "Login"
    And I fill in "invisi@abv.bg" for "user_email"
    And I fill in "12345678" for "user_password"
    And I press "Log in"
    And I click "Logout"
    Then I should see "LOGIN"