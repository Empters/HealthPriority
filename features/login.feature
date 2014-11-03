#encoding: utf-8
Feature: See if login works

  Scenario: Try to login as a user
    Given we have a user
    When login with this user
    Then login is successful

  Scenario: Log out as a user
    Given we have a user
    When login with this user
    And we click sign out
    Then logout is successful