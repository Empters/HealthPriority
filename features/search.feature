#encoding: utf-8
Feature: Check if we are able to search

  Scenario: Search for a product by name
    Given we have product called "SEARCH_PRODUCT"
    And I am on the home page
    When I fill in "SEARCH" for "search_input"
    And I click "search_link"
    Then I should see "SEARCH_PRODUCT"