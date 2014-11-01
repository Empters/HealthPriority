#encoding: utf-8
Feature: Check if we are able to search

  Scenario: Search for a product by name
    Given we have product called "My_Needed_Product"
    When I visit the homepage
    And Search by "Needed"
    Then I have to see the My_Needed_Product