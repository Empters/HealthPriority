#encoding: utf-8
Feature: Check if we are able to search

  Scenario: Search for a product by name
    Given I am on the home page
    When I fill in "Product_3" for "search_input"
    And I click "search_link"
    Then I should see "Product_3"
    And I should not see "Product_1"