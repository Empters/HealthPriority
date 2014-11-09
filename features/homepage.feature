#encoding: utf-8
Feature: See if homepage is available

  Scenario: Inspect home page
    When I am on the home page
    Then I should see "OUR CATEGORIES"
    And I should see "OUR FEATURED PRODUCTS"
    And I should see "LAST VISITED PRODUCTS"
    And I should see "E-MAIL NEWSLETTER"

  Scenario: Navigate to About us page
    Given I am on the home page
    When I click "ABOUT US"
    Then I should be on the about_us page

  Scenario: Navigate to Products page
    Given I am on the home page
    When I click "PRODUCTS"
    Then I should be on the products page

  Scenario: Navigate to Special Offers page
    Given I am on the home page
    When I click "SPECIAL OFFERS"
    Then I should be on the special_offers page

  Scenario: Navigate to Only Organic page
    Given I am on the home page
    When I click "ONLY ORGANIC"
    Then I should be on the only_organics page

  Scenario: Navigate to Contacts page
    Given I am on the home page
    When I click "CONTACTS"
    Then I should be on the contacts page

  Scenario: Navigate to FAQ page
    Given I am on the home page
    When I click "FAQ"
    Then I should be on the faq page

  Scenario: Navigate to Delivery page
    Given I am on the home page
    When I click "DELIVERY"
    Then I should be on the delivery page

  Scenario: See products in home page
    Given we have 3 products
    When I am on the home page
    Then I should see "PRODUCT_1"