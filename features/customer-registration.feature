Feature: Customer Registration
  As a new visitor to ParaBank
  I want to register for an online account
  So that I can access online banking services without visiting a branch

  Background:
    Given I am a new visitor on the ParaBank homepage

  Scenario: Successful registration with all valid required fields
    When I click the "Register" link
    And I fill in all required registration fields with valid values
    And I enter a matching Password and Confirm Password
    And I submit the registration form
    Then I should see a "Registration Complete" confirmation
    And I should be automatically logged in

  Scenario: Registration fails when a required field is left empty
    When I click the "Register" link
    And I fill in the registration form leaving a required field empty
    And I submit the registration form
    Then I should see a validation error for the empty field
    And no account should be created

  Scenario: Registration fails when the username already exists
    When I click the "Register" link
    And I fill in all required registration fields using a username that is already registered
    And I submit the registration form
    Then I should see a username-already-exists error
    And no account should be created

  Scenario: Registration fails when Password and Confirm Password do not match
    When I click the "Register" link
    And I fill in all required registration fields with a new username
    And I enter a Password and a different Confirm Password
    And I submit the registration form
    Then I should see a password-mismatch error
    And no account should be created
