# AC Validation: Fund Transfer Between Accounts

Source: `stories/fund-transfer.md`

## Story analysis (Stage 1)

**Actors:** logged-in bank customer.

**Preconditions (implied, not stated):** customer is authenticated; customer owns at least one account with a balance; a destination account number exists to transfer to.

**Business rules stated:**
- Source account is selected, destination account number is entered.
- Amount is entered, transfer is confirmed.
- Insufficient balance → transfer fails.
- Success → confirmation message shown.

**Testable restatement:** Given a logged-in customer with a source account of known balance, when they select the source account, enter a destination account number and amount, and confirm: if `amount ≤ available balance`, the transfer succeeds, the balance is reduced by `amount`, and a confirmation message is shown; if `amount > available balance`, the transfer is rejected. No behavior is defined for any other input condition (see gaps below).

**Open questions:**
1. What happens with an invalid or non-existent destination account number? Not addressed at all.
2. What happens with a zero or negative amount? Not addressed at all.
3. Is the failure message text/copy defined anywhere ("insufficient balance" wording, confirmation wording)? Not specified.
4. Can a customer select a destination account they don't own, or is any account number acceptable? Ownership/authorization model for the *destination* isn't discussed (only "my account" for source).
5. Self-transfer: is source == destination allowed?
6. Multi-currency / decimal precision: is there a minimum unit or currency constraint?
7. Any per-transaction or daily limit?
8. Duplicate/double-submit handling (idempotency)?
9. Concurrency: two simultaneous transfers from the same account each individually valid but combined exceeding balance?
10. Account status: frozen/closed/dormant source or destination account?
11. Session expiry mid-flow?

## AC validation (Stage 2)

| AC line | Testable? | Unambiguous? | Independent? |
|---|---|---|---|
| User can select a source account and enter a destination account number | Yes (presence/selection) | Partially — no rule for invalid/non-existent destination account | Yes |
| User enters an amount and confirms the transfer | Yes (happy path) | Partially — no rule for zero/negative/malformed amount | Yes |
| Transfer fails if the balance is insufficient | Yes | Yes, for the failure condition itself; message copy undefined | Yes |
| User receives a confirmation message on success | Yes (presence check) | Partially — exact copy/content undefined | Depends on above (only reachable via a successful transfer) |

**AC → test case mapping:**
- "select source account / enter destination account number" → TC-fund-transfer-001 (happy path); no case exists for invalid destination — gap.
- "enter amount and confirm" → TC-fund-transfer-001, TC-fund-transfer-003, TC-fund-transfer-004 (boundary); no case exists for zero/negative amount — gap.
- "fails if balance insufficient" → TC-fund-transfer-002, TC-fund-transfer-004.
- "confirmation message on success" → TC-fund-transfer-001.

**Missing negative/edge/permission/concurrency scenarios (explicitly not covered by any AC):**
- Invalid or non-existent destination account number.
- Zero or negative transfer amount.
- Self-transfer (source == destination).
- Duplicate/double-submit of the same transfer.
- Concurrent transfers that individually pass but combined exceed balance.
- Frozen/closed/dormant source or destination account.
- Malformed/non-numeric amount input.
- Authorization: does the customer control which accounts count as valid "source" accounts (i.e., only their own)? Not addressed for destination side.
- Per-transaction/daily transfer limits.
- Session/auth expiry mid-flow.
