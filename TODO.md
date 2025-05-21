# Todo

## Documentation
- [x] **T001 · Chore · P1: update `docs/code_quality.md` to forbid pre-commit bypass and detail emergency procedures**
    - **Context:** Remediation Plan – Sprint X, cr-02 Docs: Forbid Pre-commit Bypass, Remove Instructions
    - **Action:**
        1. Rewrite the "Bypass" section in `docs/code_quality.md` to state `git commit --no-verify` is **strictly forbidden** except for documented emergencies with explicit senior engineering approval.
        2. Update section to require any such bypass to be justified in the commit message and linked to an issue/ticket.
        3. Remove or heavily gate instructions on *how* to bypass pre-commit hooks within `docs/code_quality.md`.
    - **Done‑when:**
        1. `docs/code_quality.md` reflects the strict bypass policy, emergency approval, and justification requirements.
        2. Instructions for bypassing pre-commit hooks are removed or appropriately restricted.
    - **Verification:**
        1. Review `docs/code_quality.md` to confirm policy clarity and removal/restriction of bypass instructions.
    - **Depends‑on:** none

- [ ] **T004 · Chore · P1: update `docs/code_quality.md` regarding ci swiftlint version enforcement**
    - **Context:** Remediation Plan – Sprint X, cr-01 CI: Enforce SwiftLint Version Parity & Fail on Mismatch, Step 3
    - **Action:**
        1. Update the CI Integration section in `docs/code_quality.md`.
        2. Remove any statements about CI SwiftLint version potentially differing from `Package.resolved`.
        3. State that CI now enforces the SwiftLint version pinned in `Package.resolved` (via `$SWIFTLINT_VERSION`).
    - **Done‑when:**
        1. `docs/code_quality.md` accurately reflects that CI installs and verifies the pinned SwiftLint version.
    - **Verification:**
        1. Review the CI Integration section in `docs/code_quality.md` for accuracy.
    - **Depends‑on:** [T003]

- [ ] **T007 · Chore · P1: update `docs/swiftlint_ruleset_review.md` with disabled rule ticket ids and timelines**
    - **Context:** Remediation Plan – Sprint X, cr-03 SwiftLint: Track Disabled Rules with Backlog & Ticket Refs, Step 2
    - **Action:**
        1. Edit `docs/swiftlint_ruleset_review.md`.
        2. List the backlog ticket IDs created for tracking the re-enablement of disabled SwiftLint rules.
        3. Include any known target timelines or review cadences for these rules.
    - **Done‑when:**
        1. `docs/swiftlint_ruleset_review.md` is updated with backlog ticket IDs for all relevant disabled SwiftLint rules and any associated timelines.
    - **Verification:**
        1. Review `docs/swiftlint_ruleset_review.md` to ensure all relevant ticket IDs and timelines are accurately listed.
    - **Depends‑on:** [T005]

- [ ] **T012 · Chore · P1: document swiftformat tool and usage in `docs/code_quality.md`**
    - **Context:** Remediation Plan – Sprint X, cr-05 Tooling: Integrate Automated Code Formatting (SwiftFormat), Step 5
    - **Action:**
        1. Add a new section or update an existing one in `docs/code_quality.md` to describe the integrated code formatting tool (SwiftFormat).
        2. Include its purpose, how it's configured (mentioning `.swiftformat`), and how it's enforced (pre-commit hooks, CI).
    - **Done‑when:**
        1. `docs/code_quality.md` is updated with comprehensive documentation for SwiftFormat.
    - **Verification:**
        1. Review the SwiftFormat section in `docs/code_quality.md` for clarity, accuracy, and completeness.
    - **Depends‑on:** [T009, T010, T011]

## SwiftLint & CI
- [ ] **T002 · Bugfix · P1: activate `explicit_self` swiftlint rule in `.swiftlint.yml`**
    - **Context:** Remediation Plan – Sprint X, cr-04 SwiftLint: Fix `analyzer_rules` for `explicit_self`
    - **Action:**
        1. Add `explicit_self` to the `opt_in_rules` list in the `.swiftlint.yml` file.
    - **Done‑