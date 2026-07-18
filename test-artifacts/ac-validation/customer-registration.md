# AC Validation: Customer Registration

Source: `stories/customer-registration.md`

## Story analysis (Stage 1)

**Actors:** unauthenticated new visitor to ParaBank.

**Preconditions (implied, not stated):** visitor is on the ParaBank homepage; visitor does not already have an account.

**Business rules stated:**
- Registration form reached via the homepage "Register" link.
- Required fields: First Name, Last Name, Address, City, State, Zip Code, Phone Number, SSN, Username, Password, Confirm Password.
- All fields required; empty required fields show validation errors.
- Username must be unique; duplicate username → registration fails.
- Password and Confirm Password must match.
- Success → "Registration Complete" confirmation and automatic login.

**Testable restatement:** Given an unauthenticated visitor on the ParaBank homepage, when they open the registration form, fill all required fields, and submit: if any required field is empty, a validation error is shown for that field and no account is created; if the chosen username already exists, registration is rejected; if Password ≠ Confirm Password, registration is rejected; otherwise the account is created, a "Registration Complete" confirmation is shown, and the visitor is automatically authenticated.

**Open questions:**
1. No format validation is specified for Zip Code, Phone Number, or SSN (allowed characters, length, country format).
2. **SSN is collected as a required field with no stated handling for masking, storage, or transmission security** — worth flagging beyond testability, given it's sensitive PII on a demo banking app.
3. No email field is listed at all — unusual for an account-registration flow; confirm this is intentional and not a missing requirement.
4. Password complexity rules (minimum length, character requirements) are not specified.
5. Is the "username already exists" check case-sensitive?
6. Exact copy for the empty-field validation error, the duplicate-username error, and the password-mismatch error is not specified.
7. Is there any check preventing the same person (same SSN) from registering multiple accounts under different usernames?
8. "Automatically logged in" — is the visitor redirected to an authenticated account overview, or is it only a background session/token change? Not specified.
9. Field length limits (min/max characters per field) are not specified.
10. Behavior when Username and Password/Confirm Password are both invalid simultaneously (e.g., duplicate username AND mismatched passwords) — which error is shown, one or both? Not specified.
11. Behavior on network/server failure mid-submission (partial account creation) is not addressed.
12. Whitespace-only input in a required field — does it count as "empty"?

## AC validation (Stage 2)

| AC line | Testable? | Unambiguous? | Independent? |
|---|---|---|---|
| Access registration form from homepage "Register" link | Yes | Yes | Yes |
| Must provide the 11 listed fields | Yes (presence) | Partially — format rules for Zip/Phone/SSN undefined | Yes |
| All fields required; validation errors for empty fields | Yes | Partially — error copy undefined, whitespace-only handling undefined | Yes (uniform rule across 11 fields, so one representative case covers the mechanism — see Stage 4) |
| Username must be unique; fails if it already exists | Yes | Partially — case-sensitivity and error copy undefined | Yes |
| Password and Confirm Password must match | Yes | Partially — error copy undefined | Yes |
| Success → "Registration Complete" + auto-login | Yes | Partially — "logged in" destination/state undefined | Depends on all preceding ACs passing |

**AC → test case mapping:**
- "access registration form" → TC-customer-registration-001 (implicit first step of every scenario).
- "all fields required" → TC-customer-registration-002 (representative case for the uniform rule across all 11 fields).
- "username must be unique" → TC-customer-registration-003.
- "password/confirm match" → TC-customer-registration-004.
- "success confirmation + auto-login" → TC-customer-registration-001.

**Missing negative/edge/permission/concurrency scenarios (not covered by any AC):**
- Format validation for SSN, Phone Number, Zip Code (malformed input).
- Password complexity/weak-password acceptance.
- Case sensitivity of username uniqueness check.
- Duplicate registration using the same SSN under a different username (identity/fraud concern).
- Whitespace-only input in a required field.
- Concurrent registration attempts using the same username (race condition on uniqueness check).
- Field length limits (very long input).
- Combined failure (duplicate username *and* password mismatch in the same submission).
- Network/server error mid-submission.
- Resubmission via browser back button after a successful registration.
