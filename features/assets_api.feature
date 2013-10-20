#encoding: utf-8
@api
Feature: The HTTP API should return assets

  Background:
    Given the following assets exist:
      | name         | version |
      | jquery       | 1.9.2   |
      | jquery       | 1.9.1   |
      | handlebars   | 1.0.0   |
      | jquery-timer | 0.6     |

  Scenario: Simple asset fetch
    When I send a GET request for "/assets/jquery/1.9.2"
    Then the response status should be 302
    And the "Location" header should match "jquery/1.9.2"

  Scenario: Optimistic version matching
    When I send a GET request for "/assets/jquery/1.9.X"
    Then the response status should be 302
    And the "Location" header should match "jquery/1.9.2"
