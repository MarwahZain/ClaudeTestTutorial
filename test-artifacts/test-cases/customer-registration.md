# Test Cases: Customer Registration

Source: `stories/customer-registration.md`

| ID | Title | Preconditions | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-customer-registration-001 | Successful registration with all valid required fields | Visitor on ParaBank homepage; username to be used does not already exist | 1. Click "Register" link. 2. Fill in all 11 required fields with valid values. 3. Enter matching Password and Confirm Password. 4. Submit the form. | Account is created; "Registration Complete" confirmation is shown; visitor is automatically logged in. | High |
| TC-customer-registration-002 | Registration fails when a required field is left empty | Visitor on ParaBank homepage | 1. Click "Register" link. 2. Fill in all required fields except one (e.g. First Name) left empty. 3. Submit the form. | Validation error shown for the empty field; form is not submitted; no account created. (Representative case: the AC states this rule uniformly across all 11 required fields — see traceability note below.) | High |
| TC-customer-registration-003 | Registration fails when username already exists | Visitor on ParaBank homepage; a username already registered in test data | 1. Click "Register" link. 2. Fill in all required fields, using the pre-existing username. 3. Submit the form. | Registration rejected; username-already-exists error shown; no new account created. | High |
| TC-customer-registration-004 | Registration fails when Password and Confirm Password do not match | Visitor on ParaBank homepage; username to be used does not already exist | 1. Click "Register" link. 2. Fill in all required fields with a new username. 3. Enter a Password and a different Confirm Password. 4. Submit the form. | Registration rejected; password-mismatch error shown; no account created. | High |

## Traceability
- "Access registration form from homepage" → implicit first step of every case above.
- "All fields required" → TC-customer-registration-002 (one representative field; the rule applies uniformly to all 11 fields per the AC).
- "Username must be unique" → TC-customer-registration-003.
- "Password/Confirm Password must match" → TC-customer-registration-004.
- "Success confirmation + auto-login" → TC-customer-registration-001.

## Blocked / needs clarification

Cannot be written as deterministic test cases until the corresponding open question in `test-artifacts/ac-validation/customer-registration.md` is resolved — the story defines no expected behavior for these:

- Format validation for SSN, Phone Number, Zip Code — open question 1.
- Password complexity / weak-password acceptance — open question 4.
- Case-sensitivity of the username-uniqueness check — open question 5.
- Duplicate registration using the same SSN under a different username — open question 7.
- Whitespace-only input in a required field — open question 12.
- Field length limits (very long input) — open question 9.
- Combined failure: duplicate username *and* password mismatch in the same submission — open question 10.
- Network/server error mid-submission — open question 11.
