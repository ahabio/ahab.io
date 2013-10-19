#encoding: utf-8
@www @js
Feature: Package Search
  As a website developer
  In order to find components with which to build my app
  I want to search

  Scenario: Successful Search
    Given I am on the home page
    And the following assets exist:
      | name         | version |
      | jquery       | 1.9.2   |
      | jquery       | 1.9.1   |
      | handlebars   | 1.0.0   |
      | jquery-timer | 0.6     |
    When I search for "jquery"
    Then I should see the following search results:
      | name         |
      | jquery       |
      | jquery-timer |
