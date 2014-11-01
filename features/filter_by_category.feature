#encoding: utf-8
Feature: Check if we are able to search

  Scenario: Filter products by category
    Given we have product called "My_Filtered_Product"
    When I visit the homepage
    And Click on the category of created product
    Then I have to see the product