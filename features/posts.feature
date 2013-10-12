Feature: Manage posts

  @javascript
  Scenario: Create posts
    Given I am not authenticated
    When I log in

    Given I am on posts page
    When I follow "create new post"

    When I fill post form
    And I submit posts form

    Then I should be on posts page
    And I should see my new post

