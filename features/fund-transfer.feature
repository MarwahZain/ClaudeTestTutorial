Feature: Fund Transfer Between Accounts
  As a logged-in bank customer
  I want to transfer money from my account to another account
  So that I can pay someone without visiting a branch

  Background:
    Given I am logged in as a bank customer
    And my source account has a balance of $500.00
    And a valid destination account exists

  Scenario: Successful transfer with sufficient balance
    When I select my source account
    And I enter the destination account number
    And I enter a transfer amount of $100.00
    And I confirm the transfer
    Then the transfer should be completed successfully
    And I should see a confirmation message
    And my source account balance should be $400.00

  Scenario: Transfer fails due to insufficient balance
    When I select my source account
    And I enter the destination account number
    And I enter a transfer amount of $600.00
    And I confirm the transfer
    Then the transfer should be rejected
    And I should see a failure message
    And my source account balance should remain $500.00

  Scenario Outline: Boundary values on transfer amount
    When I select my source account
    And I enter the destination account number
    And I enter a transfer amount of "<amount>"
    And I confirm the transfer
    Then the result should be "<result>"
    And my source account balance should be "<resulting balance>"

    Examples:
      | amount  | result     | resulting balance |
      | $500.00 | success    | $0.00              |
      | $500.01 | rejected   | $500.00            |
