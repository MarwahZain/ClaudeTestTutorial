# ClaudeTestTutorial

Manual-first QA workflow for the ParaBank demo app, run through Claude Code: story analysis → AC validation → test plan → test cases → (only on request) Playwright automation.

## Workflow

For each user story:

1. **Analyze** the story and flag ambiguities
2. **Validate AC** — completeness, testability, missing edge cases
3. **Test plan** / strategy
4. **Test cases** — ID, preconditions, steps, expected result, risk-based priority (High/Med/Low)
5. **Automation** — Playwright, only run explicitly or via `/run-tests`

This is enforced by `CLAUDE.md` and the Claude Code skills in `.claude/skills/`.

## Repo structure

| Path | Purpose |
|---|---|
| `stories/` | Source user stories (input) |
| `features/` | Gherkin `.feature` files derived from stories |
| `test-artifacts/ac-validation/` | AC validation notes per story |
| `test-artifacts/test-plans/` | Test strategy/plan per story |
| `test-artifacts/test-cases/` | Test case tables per story |
| `test-artifacts/execution-logs/` | Output from automated test runs |
| `test-data/` | Test data fixtures (e.g. `users.json`) |
| `.claude/skills/` | `manual-test-workflow`, `execute-registration`, `execute-browser-flow`, `code-review` |
| `.claude/commands/` | Custom slash commands (`/run-tests`) |
| `index.html` | Legacy Tic-Tac-Toe demo, unrelated to the QA workflow — kept from before the repo's pivot |

## Stories covered

- `customer-registration`
- `customer-login`
- `fund-transfer`

Each has AC validation, a test plan, and test cases under `test-artifacts/`.

## Test data conventions

- **Registration**: unique username + SSN generated per run (timestamp-based)
- **Login**: fixed seed account for standalone login tests
- **Register → login chain**: credentials passed in-run from registration to login, never hardcoded

## Usage

1. Drop a new story into `stories/`.
2. Ask Claude Code to run the manual test workflow — it produces AC validation, test plan, and test cases in `test-artifacts/`.
3. Once test cases are finalized, run `/run-tests` (or ask explicitly) to automate them with Playwright.
