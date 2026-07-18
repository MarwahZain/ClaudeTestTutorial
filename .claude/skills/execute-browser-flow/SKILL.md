---
name: execute-browser-flow
description: Use when the user asks to actually run/execute/perform a test case or flow in a real browser using Playwright MCP tools, as opposed to just designing test artifacts.
---

# Execute Browser Flow

1. Read the relevant test case(s) from test-artifacts/test-cases/<story-name>.md
   (or the story file directly if no test cases exist yet)

2. If the flow requires unique data (e.g. registration), generate it:
   - Fields like username, SSN: unique per run (timestamp/random)
   - Other fields: static fake data unless the test case specifies otherwise

3. Use Playwright MCP browser tools to:
   - Navigate to the URL specified in the test case (or the project's base URL 
     from CLAUDE.md if not specified)
   - Perform each step exactly as written in the test case
   - Take a snapshot to verify the expected result

4. If the flow generates reusable data (new accounts, credentials), save it to
   test-data/<flow-name>.json, appending rather than overwriting

5. Report pass/fail per test case, matching against its "Expected Result" column

6. Always call browser_close as the final action, whether the flow 
   succeeded or failed — this is required for the video recording to 
   be written to disk.
   

   ## Data handling rules
- Never read all of test-data/ into context proactively. Only read the 
  specific file needed for the current flow (e.g. users.json when 
  running a login test).
- When appending new data, read the existing file, add the new entry, 
  write it back — don't hold prior runs' data in conversation context 
  longer than needed for the current step.