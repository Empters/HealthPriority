#encoding: utf-8
Feature: Check if we are able to search

  Scenario: Search for a product by name
    Given I am on the home page
    And I fill in "Product_3" for "search_input"
    When I click element "#search_link"
    Then I should see "PRODUCT_3"
    And I should not see "PRODUCT_1"