---
name: "code-review"
description: "Review changes in this repo (vanilla HTML/CSS/JS, no build step) against this project's conventions: dependency-free single-file structure, accessibility, theme support, and game-logic correctness. Use for any diff or file review in this project, in addition to or instead of the general-purpose /code-review."
---

Review the current diff (or the specified file) against this project's own conventions. This repo is a single self-contained `index.html` (HTML/CSS/JS) tic-tac-toe game — no build tools, bundlers, or external dependencies.

Report findings ranked most-severe first. For each: file, line, what's wrong, and a concrete failure scenario. If nothing applies, say so — don't invent issues.

## Checklist

**1. No build step / no dependencies**
Flag any change that introduces a package manager, bundler, CDN script tag, external stylesheet/font, or `<script src>` pointing outside the file. Everything must stay inlined in `index.html` and runnable by opening the file directly in a browser.

**2. Accessibility**
- Interactive elements (board cells, buttons) must be real `<button>`s or have proper `role`/`tabindex`/keyboard handlers — never a `<div>` with only a click handler.
- Check for meaningful ARIA labels or visible text on controls whose purpose isn't obvious from a screen reader's perspective (e.g. an empty cell should announce its position/state).
- Verify focus is reachable and visible when tabbing through the board.

**3. Theme support**
Any new color or background must work in both light and dark mode. Check that new styles respect `prefers-color-scheme` (or the existing CSS custom properties in `index.html`) rather than hardcoding a color that only looks right in one theme.

**4. No unsafe DOM/string handling**
Flag `innerHTML`/`insertAdjacentHTML` usage with any non-constant string, and inline `on*=` attributes built from data — prefer the existing pattern of `textContent` + `addEventListener` already used in `index.html`.

**5. Game-logic correctness**
For any change touching board state, win detection, or turn handling: check edge cases — full-board draws, simultaneous win lines, stale `disabled` state after a reset, and (if the computer-opponent code is touched) that minimax still treats depth correctly so it doesn't pick a losing/delayed move.

**6. Style consistency**
Match the existing formatting in `index.html`: 2-space indentation, camelCase JS identifiers, CSS custom properties for colors (no new hardcoded hex values scattered through rules).
