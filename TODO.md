```markdown
# Todo

## SwiftLint Integration

- [x] **T001 · Chore · P1: add swiftlint spm package dependency to project**
    - **Context:** Plan Details > Detailed Build Steps > 1. Add SwiftLint Package Dependency
    - **Action:**
        1. In Xcode, use `File > Add Packages...` to add the SwiftLint repository URL: `https://github.com/realm/SwiftLint.git`.
        2. Set the "Dependency Rule" to "Up to Next Major Version" or a specific version (e.g., `0.55.1` or newer, as per plan).
        3. Add the package to the main application target (e.g., "Scry").
    - **Done‑when:**
        1. SwiftLint package is listed in the Xcode project's Package Dependencies section.
        2. The `Package.resolved` file is updated to include the SwiftLint dependency.
    - **Verification:**
        1. Open the Xcode project and confirm SwiftLint appears in the Package Dependencies section of the project navigator.
        2. Inspect `Package.resolved` to ensure the SwiftLint entry is present and correct.
    - **Depends‑on:** none

- [x] **T002 · Chore · P1: apply swiftlintplugin to main app target**
    - **Context:** Plan Details > Detailed Build Steps > 2. Apply SwiftLintPlugin to Target
    - **Action:**
        1. Select the main application target (e.g., "Scry") in the Xcode project editor.
        2. Navigate to the "Build Phases" tab.
        3. In the "Run Build Tool Plug-ins" phase, click the "+" button and add `SwiftLintPlugin`.
    - **Done‑when:**
        1. `SwiftLintPlugin` is listed in the "Run Build Tool Plug-ins" phase for the "Scry" target.
    - **Verification:**
        1. Check the "Scry" target's "Build Phases" tab in Xcode to confirm the plugin is correctly added.
    - **Depends‑on:** [T001]

- [ ] **T003 · Chore · P1: create baseline `.swiftlint.yml` configuration file**
    - **Context:** Plan Details > Detailed Build Steps > 3. Create and Configure `.swiftlint.yml`
    - **Action:**
        1. Create a file named `.swiftlint.yml` at the project root directory.
        2. Populate this file with the *initial baseline* configuration, including rules and comments, as provided in `PLAN.md`.
        3. Commit the `.swiftlint.yml` file to version control.
    - **Done‑when:**
        1. `.swiftlint.yml` file exists at the project root.
        2. The file contains the specified baseline rules and configurations from `PLAN.MD`.
    - **Verification:**
        1. Validate the file's presence at the project root and its content against the baseline specified in `PLAN.MD`.
    - **Depends‑on:** none

- [ ] **T004 · Test · P1: verify local swiftlint build enforcement**
    - **Context:** Plan Details > Detailed Build Steps > 4. Verify Local Integration; Testing Strategy (Local Build)
    - **Action:**
        1. Clean the project (`Cmd+Shift+K`) and then build it (`Cmd+B`) in Xcode.
        2. Intentionally introduce a clear lint violation (e.g., a `print("test")` statement or a line exceeding configured length) in a Swift source file.
        3. Build the project again; verify that Xcode shows an error for the violation and the build fails.
        4. Fix the introduced violation and build again; verify the build now succeeds.
    - **Done‑when:**
        1. Local Xcode builds correctly trigger the SwiftLint plugin.
        2. Lint violations (configured as errors) cause the local build to fail, with errors reported in Xcode's Issue Navigator.
        3. Fixing these violations allows the local build to succeed.
    - **Verification:**
        1. Observe Xcode's Issue Navigator for SwiftLint errors when a violation is present.
        2. Confirm build failure with violations and success after fixing.
    - **Depends‑on:** [T002, T003]

- [ ] **T005 · Chore · P1: ensure ci swiftlint cli version matches spm plugin version**
    - **Context:** Plan Details > Detailed Build Steps > 5. Integrate SwiftLint into CI Workflow; Error & Edge‑Case Strategy (Inconsistent SwiftLint Version); Risk Matrix (Inconsistent SwiftLint version)
    - **Action:**
        1. Determine the exact SwiftLint version used by the SPM plugin from the `Package.resolved` file.
        2. Update the CI configuration to install this specific version of the SwiftLint CLI (e.g., using Homebrew with a pinned version, or downloading a specific release artifact).
        3. Add a script step in the CI pipeline to verify that the installed SwiftLint CLI version matches the version found in `Package.resolved`, failing the CI job if they do not match.
    - **Done‑when:**
        1. The CI pipeline installs a specific SwiftLint CLI version that aligns with the version in `Package.resolved`.
        2. A CI job step actively verifies this version alignment and fails the build on mismatch.
    - **Verification:**
        1. Check CI logs to confirm the correct SwiftLint CLI version is installed.
        2. Test the version verification step by (temporarily) forcing a mismatch to ensure it fails as expected.
    - **Depends‑on:** [T001]

- [ ] **T006 · Chore · P1: add swiftlint lint command to ci workflow**
    - **Context:** Plan Details > Detailed Build Steps > 5. Integrate SwiftLint into CI Workflow; Architecture Blueprint (CI Job Step); Error & Edge‑Case Strategy (Lint Violations CI)
    - **Action:**
        1. In the CI configuration file (e.g., GitHub Actions `.yml`), add a new step after code checkout and SwiftLint CLI setup.
        2. Configure this step to execute the command: `swiftlint lint --strict --config .swiftlint.yml`.
        3. Ensure the CI job is configured to fail if this SwiftLint command exits with a non-zero status code.
    - **Done‑when:**
        1. The CI pipeline includes a dedicated step that runs `swiftlint lint --strict --config .swiftlint.yml`.
        2. The CI job correctly fails if SwiftLint reports any violations (due to `--strict`).
    - **Verification:**
        1. Push code with an intentional lint violation (that would pass locally if not for `--strict`, or a new error) and confirm the CI job fails at the linting step.
        2. Push compliant code and confirm the CI job passes the linting step.
    - **Depends‑on:** [T003, T005]

- [ ] **T007 · Chore · P2: document swiftlint integration, usage, and initial policies**
    - **Context:** Plan Details > Detailed Build Steps > 6. Document SwiftLint Usage; Documentation (Required readme updates)
    - **Action:**
        1. Create or update project documentation (e.g., `README.md`, `CONTRIBUTING.md`, or a dedicated `docs/code_quality.md`).
        2. Include: purpose of SwiftLint (code quality, consistency); how it's integrated (SPM plugin, automatic on Xcode build); link to the project's `.swiftlint.yml` file; link to official SwiftLint rules documentation; and basic troubleshooting tips (e.g., plugin not in "Run Build Tool Plug-ins").
    - **Done‑when:**
        1. Project documentation is updated/created with the specified SwiftLint details.
    - **Verification:**
        1. Review the documentation to ensure all points are covered clearly and accurately.
    - **Depends‑on:** [T004, T006]

- [ ] **T008 · Chore · P2: define and document process for `.swiftlint.yml` changes and `swiftlint:disable` usage**
    - **Context:** Plan Details > Open Questions (process for `.swiftlint.yml` changes); Detailed Build Steps > 6. Document SwiftLint Usage (policy on `.swiftlint.yml` & `swiftlint:disable`); Risk Matrix (`.swiftlint.yml` becomes outdated)
    - **Action:**
        1. Define the project's policy for proposing and approving changes to the `.swiftlint.yml` file (e.g., changes via PR, rationale required, team review/approval).
        2. Define the project's strict policy on using `swiftlint:disable` comments (discouraged; requires strong justification, approval, and an inline comment explaining *why* it's necessary).
        3. Add these defined policies to the project documentation updated in T007.
    - **Done‑when:**
        1. Policies for managing `.swiftlint.yml` changes and the use of `swiftlint:disable` comments are clearly defined and documented.
    - **Verification:**
        1. Review the documented policies within the project documentation for clarity, completeness, and enforceability.
    - **Depends‑on:** [T007]

- [ ] **T009 · Chore · P2: identify and configure initial code exclusions in `.swiftlint.yml`**
    - **Context:** Plan Details > Open Questions (Are there any existing codebases or generated files that need to be explicitly excluded in `.swiftlint.yml` from the outset?)
    - **Action:**
        1. Review the ScryiOS codebase to identify any third-party code, auto-generated files, or specific directories that should be excluded from SwiftLint analysis from the beginning.
        2. Update the `excluded:` section in the `.swiftlint.yml` file (created in T003) with these identified paths.
        3. Commit the changes to `.swiftlint.yml`.
    - **Done‑when:**
        1. The `.swiftlint.yml` file is updated to include necessary initial exclusions.
    - **Verification:**
        1. Perform a local build or run `swiftlint lint` and confirm that no linting violations are reported from the intentionally excluded files or paths.
    - **Depends‑on:** [T003]

- [ ] **T010 · Chore · P1: conduct team review and finalize initial `.swiftlint.yml` ruleset**
    - **Context:** Plan Details > Open Questions (What is the definitive initial set of rules for `.swiftlint.yml`?)
    - **Action:**
        1. Schedule and conduct a team review of the baseline `.swiftlint.yml` (from T003, potentially updated with exclusions from T009).
        2. Discuss and apply any agreed-upon adjustments, rule additions/removals, or threshold changes to align with Scry-specific needs and team consensus.
        3. Commit the finalized `.swiftlint.yml` after the review and adjustments.
    - **Done‑when:**
        1. Team review of the `.swiftlint.yml` configuration is completed.
        2. The `.swiftlint.yml` file is updated to reflect the finalized ruleset and committed to version control.
    - **Verification:**
        1. Pull Request review comments, meeting notes, or a similar artifact confirms team agreement on the finalized ruleset.
    - **Depends‑on:** [T003, T009]

- [ ] **T011 · Chore · P3: setup optional pre-commit hook for swiftlint**
    - **Context:** Plan Details > Detailed Build Steps > 7. Setup Pre-commit Hooks; Risk Matrix (Developers bypass local linting)
    - **Action:**
        1. If the team decides to proceed (see Clarification below), install `pre-commit` (e.g., `pip install pre-commit` or `brew install pre-commit`).
        2. Create a `.pre-commit-config.yaml` file at the project root, configuring it with a hook for SwiftLint (pinning to the same version as SPM, using args like `--fix`, `--config .swiftlint.yml`).
        3. Instruct developers to run `pre-commit install` to set up the git hooks locally.
        4. Add setup instructions for pre-commit hooks to the project documentation (from T007).
    - **Done‑when:**
        1. A `.pre-commit-config.yaml` file is created and configured for SwiftLint.
        2. Instructions for installing and using the pre-commit hooks are added to the project documentation.
        3. (If tested by implementer) Pre-commit hook successfully runs SwiftLint on staged files.
    - **Verification:**
        1. After setup, intentionally stage a file with a fixable lint violation and attempt to commit; verify the hook runs, fixes the issue, or blocks the commit as configured.
    - **Depends‑on:** [T003, T007]

- [ ] **T012 · Chore · P3: document fallback plan for swiftlint plugin failures**
    - **Context:** Plan Details > Risk Matrix (SwiftLint plugin issues or bugs with new Xcode/Swift versions)
    - **Action:**
        1. Document a clear fallback strategy in case the SwiftLint SPM plugin encounters critical issues with new Xcode or Swift versions (e.g., temporarily using a Run Script phase in Xcode that calls the SwiftLint CLI directly).
        2. Add this fallback plan to the project's code quality documentation (from T007).
    - **Done‑when:**
        1. A documented fallback plan for SwiftLint plugin failures is available to the team.
    - **Verification:**
        1. Review the documented fallback plan for clarity and actionable steps.
    - **Depends‑on:** [T007]

## Clarifications & Assumptions
- [ ] **Issue:** Decision on whether the optional pre-commit hook setup (T011) will be implemented as part of this initial plan or deferred.
    - **Context:** PLAN.md > Open Questions > "Will the optional pre-commit hook setup be implemented as part of this initial task or as a follow-up?"
    - **Blocking?:** no (Task T011 is P3 and can be deferred based on this decision)
```