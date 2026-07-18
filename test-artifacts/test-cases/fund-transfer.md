# Test Cases: Fund Transfer Between Accounts

Source: `stories/fund-transfer.md` · Preconditions assume a seeded source account with balance **$500.00** unless stated otherwise (see test plan).

| ID | Title | Preconditions | Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-fund-transfer-001 | Successful transfer with sufficient balance | Logged in; source account balance $500.00; valid destination account exists | 1. Go to fund transfer page. 2. Select source account. 3. Enter valid destination account number. 4. Enter amount $100.00. 5. Confirm transfer. | Transfer completes; confirmation message shown; source balance reduced to $400.00. | High |
| TC-fund-transfer-002 | Transfer fails due to insufficient balance | Logged in; source account balance $500.00; valid destination account exists | 1. Go to fund transfer page. 2. Select source account. 3. Enter valid destination account number. 4. Enter amount $600.00 (> balance). 5. Confirm transfer. | Transfer rejected; failure message shown; source balance remains $500.00. | High |
| TC-fund-transfer-003 | Transfer succeeds when amount equals exact available balance (boundary) | Logged in; source account balance $500.00; valid destination account exists | 1. Go to fund transfer page. 2. Select source account. 3. Enter valid destination account number. 4. Enter amount $500.00 (== balance). 5. Confirm transfer. | Transfer completes; confirmation message shown; source balance reduced to $0.00. | High |
| TC-fund-transfer-004 | Transfer fails when amount exceeds balance by smallest unit (boundary) | Logged in; source account balance $500.00; valid destination account exists | 1. Go to fund transfer page. 2. Select source account. 3. Enter valid destination account number. 4. Enter amount $500.01 (balance + $0.01). 5. Confirm transfer. | Transfer rejected; failure message shown; source balance remains $500.00. | High |

## Traceability
- AC "select source account / enter destination account number" → TC-fund-transfer-001.
- AC "enter amount and confirm" → TC-fund-transfer-001, 003, 004.
- AC "fails if balance insufficient" → TC-fund-transfer-002, 004.
- AC "confirmation message on success" → TC-fund-transfer-001, 003.

## Blocked / needs clarification

Cannot be written as deterministic test cases until the corresponding open question in `test-artifacts/ac-validation/fund-transfer.md` is resolved — the story defines no expected behavior for these:

- Invalid or non-existent destination account number — open question 1.
- Zero or negative transfer amount — open question 2.
- Self-transfer (source == destination) — open question 5.
- Multi-currency / decimal precision beyond standard 2-decimal — open question 6.
- Per-transaction or daily transfer limits — open question 7.
- Duplicate/double-submit of the same transfer — open question 8.
- Concurrent transfers exceeding balance combined — open question 9.
- Frozen/closed/dormant source or destination account — open question 10.
- Session/auth expiry mid-flow — open question 11.
