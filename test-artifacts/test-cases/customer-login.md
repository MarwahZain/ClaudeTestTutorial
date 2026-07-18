# Test Cases: Customer Login

Source: `stories/customer-login.md`

| ID | Title | Preconditions | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-customer-login-001 | Successful login with valid registered credentials | A valid registered account exists (seed account) | 1. On the ParaBank homepage, enter the valid Username. 2. Enter the correct Password. 3. Submit the login form. | User is redirected to the Accounts Overview page. | High |
| TC-customer-login-002 | Login rejected with correct username but wrong password | A valid registered account exists (seed account) | 1. Enter the valid Username. 2. Enter an incorrect Password. 3. Submit the login form. | Error message shown; user remains on the login page; not authenticated. | High |
| TC-customer-login-003 | Login rejected with a username that does not exist | None (username deliberately not registered) | 1. Enter a Username that is not registered. 2. Enter any Password. 3. Submit the login form. | Error message shown; user remains on the login page; not authenticated. | High |
| TC-customer-login-004 | Login rejected when Username is empty | Password field has a value | 1. Leave Username empty. 2. Enter a Password. 3. Submit the login form. | Validation message shown; form is not submitted; user remains on the login page. | Medium |
| TC-customer-login-005 | Login rejected when Password is empty | Username field has a value | 1. Enter a Username. 2. Leave Password empty. 3. Submit the login form. | Validation message shown; form is not submitted; user remains on the login page. | Medium |
| TC-customer-login-006 | Freshly registered user can log in (chained register → login) | None — a new account is registered within this same test run | 1. Register a new account, generating a unique username/password/SSN. 2. Log out if auto-logged-in. 3. On the homepage, enter the just-registered Username and Password. 4. Submit the login form. | User is redirected to the Accounts Overview page, confirming registration and login integrate correctly. | High |

## Traceability
- "Enter username/password on homepage login form" → implicit first step of every case above.
- "Valid credentials → Accounts Overview" → TC-customer-login-001, TC-customer-login-006.
- "Invalid username or password → error, remains on login page" → TC-customer-login-002 (wrong password), TC-customer-login-003 (unknown username).
- "Empty username or password rejected with validation message" → TC-customer-login-004, TC-customer-login-005.

## Blocked / needs clarification

Cannot be written as deterministic test cases until the corresponding open question in `test-artifacts/ac-validation/customer-login.md` is resolved:

- Whether "unknown username" and "wrong password" produce distinguishable error messages (username-enumeration risk) — open question 1.
- Case sensitivity of username matching — open question 2.
- Account lockout / rate limiting after repeated failed attempts — open question 3.
- Whitespace-only input in Username or Password — open question 6.
- Re-submitting login while already authenticated — open question 8.
