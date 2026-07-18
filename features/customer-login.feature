Feature: Customer Login
  As a registered ParaBank customer
  I want to log in with my username and password
  So that I can access my account services

  Background:
    Given I am on the ParaBank homepage

  Scenario: Successful login with valid registered credentials
    When I enter a valid registered Username
    And I enter the correct Password
    And I submit the login form
    Then I should be redirected to the Accounts Overview page

  Scenario: Login rejected with correct username but wrong password
    When I enter a valid registered Username
    And I enter an incorrect Password
    And I submit the login form
    Then I should see a login error message
    And I should remain on the login page

  Scenario: Login rejected with a username that does not exist
    When I enter a Username that is not registered
    And I enter any Password
    And I submit the login form
    Then I should see a login error message
    And I should remain on the login page

  Scenario: Login rejected when Username is empty
    When I leave the Username field empty
    And I enter a Password
    And I submit the login form
    Then I should see a validation message
    And the form should not be submitted

  Scenario: Login rejected when Password is empty
    When I enter a Username
    And I leave the Password field empty
    And I submit the login form
    Then I should see a validation message
    And the form should not be submitted

  Scenario: Freshly registered user can log in
    Given I have just registered a new account with a unique username and password
    When I enter the just-registered Username
    And I enter the just-registered Password
    And I submit the login form
    Then I should be redirected to the Accounts Overview page
