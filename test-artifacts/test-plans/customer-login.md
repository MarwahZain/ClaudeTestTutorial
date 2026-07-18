# Test Plan: Customer Login

Source: `stories/customer-login.md` · See `test-artifacts/ac-validation/customer-login.md` for open questions referenced below.

## Scope
**In scope:** login form access on the homepage; successful login with valid credentials and redirect to Accounts Overview; rejection of wrong password; rejection of unknown username; rejection of empty username; rejection of empty password.

**Out of scope (pending clarification — see AC validation open questions):** account lockout/rate limiting, case-sensitivity of username matching, whitespace-only input handling, concurrent-session behavior, injection/special-character resistance.

## Test levels
- **Functional** — happy-path login with valid, previously-registered credentials.
- **Negative/validation** — wrong password, unknown username, empty username, empty password.
- **Regression** — a freshly registered account (per `customer-registration.md`) can log in standalone, confirming registration and login integrate correctly.
- **Exploratory (flagged, blocked)** — lockout/rate-limiting, whitespace-only input, case sensitivity — see AC validation gaps.

## Environments / data needs
- A known, valid registered account (fixed seed account per `CLAUDE.md` test-data strategy) for standalone login testing.
- For the chained register→login scenario, credentials produced by a registration run in the same execution, not hardcoded.
- An intentionally wrong password value, and a username known not to exist, for the negative cases.

## Entry / exit criteria
- **Entry:** login form deployed to test environment; at least one valid registered account available (seed account or freshly registered).
- **Exit:** all High-priority test cases pass; no open Sev1/Sev2 defects on happy-path, wrong-password, or unknown-username paths.

## Risk-based prioritization
Valid-credential login and its redirect are High (core authentication path). Wrong-password and unknown-username rejection are High (authentication security boundary — must not leak whether a username exists via message differences, per open question 1). Empty-field validation is Medium — client-side convenience rather than a security boundary.

## Applicable techniques
- **Equivalence partitioning:** valid vs. invalid credentials; known vs. unknown username; empty vs. non-empty field (applied independently to Username and Password since they're separate inputs, unlike registration's single representative-field case).
- **Boundary value analysis:** not directly applicable — no numeric ranges defined for login inputs.
- **Decision table (flagged, not yet actionable):** {username valid/invalid} × {password valid/invalid} × {either empty} would fully characterize the login state space, but message-differentiation rules (open question 1) aren't specified enough to assert exact expected output per cell.

## Risk areas needing extra coverage
- Whether the invalid-credentials message differs for "unknown username" vs. "wrong password" is a security-relevant open question (username enumeration risk) — flag with product/security before treating this as fully covered.
- No stated lockout/rate-limiting behavior is itself a risk worth raising, independent of whether it's in scope for this story.
