Feature: Vault Helm Chart
  In order to test the module 
  I should apply a blueprint
  And test the output

  Scenario: Basic setup
    Given I have a running blueprint at path "./example"
    Then the following resources should be running
      | name                                       |
      | resource.network.local                     |
      | resource.k8s_cluster.k3s                   |
    And a HTTP call to "http://localhost:8200" should result in status 200