# AC Validation: Customer Login

Source: `stories/customer-login.md`

## Story analysis (Stage 1)

**Actors:** a registered ParaBank customer (has already completed registration).

**Preconditions (implied, not stated):** customer is on the ParaBank homepage; customer already holds a valid username/password from a prior registration.

**Business rules stated:**
- Login form (Username, Password) is on the homepage.
- Valid credentials → redirect to Accounts Overview page.
- Invalid username or password → error message shown, user stays on login page.
- Empty username or password → rejected with a validation message.

**Testable restatement:** Given a registered customer on the ParaBank homepage, when they submit the login form: if username and password are both valid and correct, they are redirected to Accounts Overview; if either field is empty, a validation message is shown and the form is not submitted; if the username/password combination is invalid (unknown username, or known username with wrong password), an error message is shown and the user remains on the login page.

**Open questions:**
1. Does the invalid-credentials error message differentiate "unknown username" from "wrong password," or is it the same generic message for both (security best practice would say same message, but the story doesn't say)?
2. Is username matching case-sensitive on login, consistent with however registration's uniqueness check behaves (see open question 5 in `customer-registration.md`)?
3. Is there any account lockout / rate limiting after repeated failed login attempts? Not mentioned.
4. Session behavior: does a successful login invalidate any prior session for the same user (e.g. logged in elsewhere)? Not specified.
5. Exact copy for the empty-field validation message and the invalid-credentials error is not specified.
6. Whitespace-only input in Username or Password — does it count as "empty"?
7. Is there a "remember me" or persistent-session option? Not mentioned, assume no.
8. What happens if a user who is already logged in navigates back to the login form and submits again?
9. Field length / character limits on Username and Password at login are not specified (irrelevant to matching since it's compared to stored credentials, but relevant to input handling / injection resistance).

## AC validation (Stage 2)

| AC line | Testable? | Unambiguous? | Independent? |
|---|---|---|---|
| User can enter Username and Password on the homepage login form | Yes | Yes | Yes |
| Valid credentials → redirected to Accounts Overview | Yes | Yes | Depends on a valid registered account existing |
| Invalid username or password → error message, remains on login page | Yes | Partially — doesn't say whether "unknown username" and "wrong password" produce the same or different messages | Yes |
| Empty username or password → rejected with validation message | Yes | Partially — exact message and whitespace-only handling undefined | Yes |

**AC → test case mapping:**
- "enter username/password on homepage" → TC-customer-login-001 (implicit first step of every scenario).
- "valid credentials → Accounts Overview" → TC-customer-login-001.
- "invalid username or password → error, stays on page" → TC-customer-login-002 (wrong password), TC-customer-login-003 (unknown username).
- "empty fields rejected" → TC-customer-login-004 (empty username), TC-customer-login-005 (empty password).

**Missing negative/edge/permission/concurrency scenarios (not covered by any AC):**
- Account lockout / rate limiting after repeated failed attempts.
- Case sensitivity of username matching.
- Whitespace-only input in Username or Password.
- Re-submitting login while already authenticated (double-login).
- SQL-injection / special-character input in Username or Password (security boundary, not just validation).
- Session behavior on concurrent logins from multiple locations.
