---
description: Automate the finalized manual test cases for a story using Playwright
---

Automate the test cases for the story named in `$ARGUMENTS` (the `<story-name>` used under `test-artifacts/`).

1. Read `test-artifacts/test-cases/<story-name>.md`. If it doesn't exist, stop and tell the user to finish the manual-test-workflow for this story first — do not invent test cases.
2. Also read the matching `test-artifacts/ac-validation/<story-name>.md` and `test-artifacts/test-plans/<story-name>.md` for context (preconditions, test data, environment assumptions) if present.
3. For each test case, write a Playwright test that mirrors its steps and expected result exactly. Preserve the test case ID in the test name/title so failures trace back to the source case.
4. Keep High-priority cases first in file/describe-block ordering.
5. Do not alter or reinterpret the manual test cases to fit automation convenience — if a case isn't automatable as written (e.g. requires manual/visual judgment), flag it and skip it rather than silently changing its intent.
