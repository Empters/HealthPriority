#encoding: utf-8
Feature: Check if we are able to search

  Scenario: Filter products by category
    Given we have product called "Filtered_Product"
    And I am on the home page
    When I click "Category_1"
    Then I should see "FILTERED_PRODUCT"