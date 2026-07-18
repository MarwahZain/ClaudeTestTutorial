# QA Testing Project

## About me
Senior QA/test automation engineer (15+ yrs), FinTech/banking/telecom/EComerce background.
Working manual-first: story analysis → AC validation → test plan → test cases → execution.
Automation (Playwright) comes after manual test cases are finalized, not before.

## Workflow
When I paste or drop a user story file into stories/, follow the manual-test-workflow skill:
1. Analyze the story, flag ambiguities
2. Validate AC (completeness, testability, missing edge cases)
3. Produce a test strategy/plan
4. Produce test cases (ID, preconditions, steps, expected result, priority)
5. Only proceed to Playwright automation if I explicitly say so, or run /run-tests

## Output conventions
- Save AC validation to test-artifacts/ac-validation/<story-name>.md
- Save test plan to test-artifacts/test-plans/<story-name>.md
- Save test cases to test-artifacts/test-cases/<story-name>.md as a table
- Use risk-based prioritization (High/Med/Low) on every test case

## Tech context
- Target stack: [fill in — e.g. React frontend, REST API backend]
- Test data conventions: [fill in]

## Test data strategy
- Registration tests: generate unique username + SSN per run (timestamp-based)
- Login tests: use a fixed seed account for standalone login testing
- Chained "register → login" scenario: pass credentials from registration 
  step to login step within the same run, don't hardcode