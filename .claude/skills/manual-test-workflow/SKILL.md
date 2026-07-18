---
name: manual-test-workflow
description: Use when the user provides a user story, feature description, or acceptance criteria and wants story analysis, AC validation, a test plan, test cases, or a Gherkin feature file produced before any automation work.
---

# Manual Test Workflow

Follow these stages in order, don't skip ahead unless told:

## Stage 1: Story Analysis
- Identify actors, preconditions, business rules
- List ambiguities or missing info as open questions
- Restate the story in a "testable" form

## Stage 2: AC Validation
- Check each AC line: is it testable? unambiguous? independent?
- Map every AC line to at least one test case
- Explicitly call out missing negative/edge/permission/concurrency scenarios

## Stage 3: Test Plan / Strategy
- Scope (in/out), test levels, environments, data needs, entry/exit criteria
- Risk-based prioritization
- Note applicable techniques: equivalence partitioning, boundary values, decision tables

## Stage 4: Test Case Design
- Format: ID | Title | Preconditions | Steps | Expected Result | Priority
- Cover positive, negative, boundary, edge cases per AC line, including gaps found in Stage 2

## Stage 5: Generate Artifacts
Produce all of the following as separate files, derived from Stages 1–4:
- `test-artifacts/ac-validation/<story-name>.md` — Stage 2 output
- `test-artifacts/test-plans/<story-name>.md` — Stage 3 output
- `test-artifacts/test-cases/<story-name>.md` — Stage 4 output, as a table
- `features/<story-name>.feature` — Gherkin version of the story:
  - One Scenario per test case (not per AC line — test cases already cover edge/negative cases)
  - Use Background for shared preconditions (e.g. login state)
  - Use Scenario Outline + Examples for boundary-value test cases
  - Keep step language business-readable, no UI selectors or implementation detail

Do NOT write Playwright step definitions or code here — that only happens 
when I explicitly run /run-tests.