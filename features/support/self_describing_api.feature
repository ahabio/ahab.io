#encoding: utf-8
@api
Feature: The HTTP API should be self-describing

  Scenario: Asset Registry URI Lookup
    When I send an OPTIONS request for "/"
    Then the response headers should include an asset URL Link
    And the response status should be 204
