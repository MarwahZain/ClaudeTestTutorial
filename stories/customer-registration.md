# Customer Registration

As a new visitor to ParaBank, I want to register for an online account,
so that I can access online banking services without visiting a branch.

## Acceptance Criteria
- User can access the registration form from the homepage "Register" link
- User must provide: First Name, Last Name, Address, City, State, Zip Code,
  Phone Number, SSN, Username, Password, Confirm Password
- All fields are required; form shows validation errors for empty required fields
- Username must be unique; registration fails if the username already exists
- Password and Confirm Password must match
- On successful submission, user sees a "Registration Complete" confirmation
  and is automatically logged in