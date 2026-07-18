# Test Plan: Fund Transfer Between Accounts

Source: `stories/fund-transfer.md` · See `test-artifacts/ac-validation/fund-transfer.md` for open questions referenced below.

## Scope
**In scope:** the four stated ACs — source account selection, destination account number entry, amount entry and confirm, insufficient-balance failure, and confirmation message on success (including resulting balance update).

**Out of scope (pending clarification — see AC validation open questions):** invalid/non-existent destination account handling, zero/negative amount handling, self-transfer, duplicate submission, concurrency, account status (frozen/closed), multi-currency, transfer limits, session expiry mid-flow.

## Test levels
- **Functional** — happy-path transfer.
- **Negative/validation** — insufficient balance.
- **Boundary** — amount exactly equal to available balance; amount = balance + smallest currency unit.
- **Regression** — balance correctness across multiple sequential transfers.

## Environments / data needs
- Test environment with a source account seeded to a known, resettable balance (e.g., $500.00) before each run.
- A valid destination account number in test data.
- Currency/decimal precision assumed to be standard 2-decimal (e.g., USD) unless stated otherwise — open question 6.

## Entry / exit criteria
- **Entry:** build deployed to test environment; test data (seeded balance, valid destination account) available.
- **Exit:** all High-priority test cases pass; no open Sev1/Sev2 defects on the happy path or insufficient-balance path.

## Risk-based prioritization
All balance-affecting logic (happy path, insufficient balance, boundary values) is High priority — this is a financial transaction and incorrect balance handling is the highest-impact failure mode. Confirmation-message-only assertions (copy/presence) are Medium.

## Applicable techniques
- **Equivalence partitioning:** amount ≤ balance vs. amount > balance.
- **Boundary value analysis:** amount == balance (boundary of the "sufficient" partition), amount == balance + smallest unit (boundary of the "insufficient" partition).
- **Decision table (flagged, not yet actionable):** the AC only defines outcomes for {valid destination × sufficient/insufficient amount}. A full decision table would also need {invalid destination × valid/invalid amount} cells, which the story does not define — see AC validation gaps before building one.

## Risk areas needing extra coverage
- Balance boundary correctness (exact balance, balance + smallest unit) — highest risk of off-by-one/rounding defects.
- Anything in "out of scope" above is a real gap for a financial transfer feature (especially concurrency and duplicate-submit) and should be raised with the product owner before release sign-off, not silently assumed safe.
