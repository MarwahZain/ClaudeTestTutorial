# Test Plan: Customer Registration

Source: `stories/customer-registration.md` · See `test-artifacts/ac-validation/customer-registration.md` for open questions referenced below.

## Scope
**In scope:** registration form access via the homepage "Register" link; presence/required validation across all 11 fields; username-uniqueness rejection; password/confirm-password match validation; success confirmation and automatic login.

**Out of scope (pending clarification — see AC validation open questions):** field-format validation (SSN/Phone/Zip specifics), password complexity rules, duplicate-SSN fraud detection, concurrency on the username-uniqueness check, combined multi-error submissions, mid-submission network failure handling.

## Test levels
- **Functional** — happy-path registration.
- **Negative/validation** — empty required field (representative case, covers the uniform rule across all 11 fields via equivalence partitioning), duplicate username, password/confirm mismatch.
- **Regression** — newly registered credentials can subsequently log in (covered by auto-login assertion in the happy-path case).
- **Exploratory (flagged, blocked)** — field-format edge cases, weak passwords, whitespace-only input — see AC validation gaps.

## Environments / data needs
- Test environment with a resettable user store so username-uniqueness tests don't collide across runs.
- A known, pre-existing username in test data to exercise the duplicate-username case.
- Valid representative values for all 11 required fields for the happy-path case.

## Entry / exit criteria
- **Entry:** registration form deployed to test environment; test data (existing username) available.
- **Exit:** all High-priority test cases pass; no open Sev1/Sev2 defects on happy path, duplicate-username, or password-mismatch paths.

## Risk-based prioritization
Username uniqueness, password matching, required-field validation, and the auto-login security boundary are all High priority — they are core account-integrity and authentication rules. Exact message copy is Medium. SSN handling/security is flagged as a concern to raise with the product owner, separate from functional priority.

## Applicable techniques
- **Equivalence partitioning:** empty vs. filled required field (one representative case stands in for all 11 fields, since the AC states a uniform rule); unique vs. duplicate username; matching vs. mismatched password.
- **Boundary value analysis:** not directly applicable — no numeric ranges are defined in this story (unlike field length limits, which are undefined — see AC validation gap).
- **Decision table (flagged, not yet actionable):** the AC only defines outcomes for each validation rule in isolation. A full decision table would need a {duplicate username × password mismatch} combined-failure cell, which the story does not define — see AC validation open question 10.

## Risk areas needing extra coverage
- SSN as a required field with no stated masking/storage handling — flag with the product owner/security review before this goes further, this is a real compliance gap for a financial registration flow.
- Combined-failure behavior (open question 10) should be resolved before claiming full coverage of the validation logic.
