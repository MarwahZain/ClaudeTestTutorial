---
name: execute-registration
description: Use when the user asks to actually run/execute/perform the ParaBank registration in a real browser, as opposed to just designing test cases.
---

# Execute Registration via Browser

1. Generate a unique user:
   - username: testuser_<current timestamp>
   - ssn: random 9-digit number
   - password: fixed value, e.g. Test1234!
   - other fields: static fake data (name, address, city, state, zip, phone)

2. Use the Playwright MCP browser tools to:
   - Navigate to https://parabank.parasoft.com/parabank/register.htm
   - Fill each field with the generated data
   - Submit the form
   - Take a snapshot/screenshot to confirm "Registration Complete"

3. Save the generated credentials to test-data/users.json, appending 
   (not overwriting) so every run accumulates a record:
   { "username": "...", "password": "...", "ssn": "...", "createdAt": "..." }

4. Report back: success/failure, and the username created.