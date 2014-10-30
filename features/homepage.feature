#encoding: utf-8
Feature: See if homepage is available

  Scenario: See products in home page
    Given we have 3 products
    When I visit the homepage
    Then I have to see the products