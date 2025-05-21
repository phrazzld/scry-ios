# Code Quality Guidelines

## SwiftLint Integration

Scry iOS uses SwiftLint to enforce code quality standards and consistent style across the codebase. This document outlines how SwiftLint is integrated, how to work with it, and our policies regarding code style.

### How SwiftLint Is Integrated

- **Build-time Integration**: SwiftLint is integrated as a Swift Package Manager build tool plugin. This means it runs automatically during the build process and will fail the build if linting errors are found.

- **Pre-commit Hook Integration**: A Git pre-commit hook is available that automatically runs SwiftLint on staged Swift files before each commit, attempting to fix issues automatically where possible. This provides early feedback and helps catch issues before they even enter the codebase.

- **CI Integration**: SwiftLint is also part of our CI pipeline, ensuring that all code submitted via pull requests meets our quality standards. Our CI setup uses Homebrew to install SwiftLint, which may result in a slightly different version than specified in Package.resolved, but ensures reliable CI operation.

### How to Work with SwiftLint

1. **Local Development**: 
   - SwiftLint runs automatically when you build the project in Xcode.
   - Linting violations appear as errors or warnings in the Xcode Issue navigator.
   - You can also run SwiftLint manually from the command line: `swiftlint lint --path /path/to/your/file.swift`

2. **Fixing Issues**:
   - Many SwiftLint issues can be auto-fixed by running: `swiftlint --fix --path /path/to/your/file.swift`
   - For issues that can't be automatically fixed, see the [SwiftLint Rules Documentation](https://realm.github.io/SwiftLint/rule-directory.html) for guidance on fixing specific rule violations.

### Policies

1. **Rule Configuration**: 
   - SwiftLint rules are configured in the `.swiftlint.yml` file at the project root.
   - The configuration includes rules, rule customizations, and file exclusions (build directories, generated files, etc.).
   - Changes to the rule configuration should be proposed via pull request with a clear rationale for the change.
   - All rule changes must align with our [Development Philosophy](./DEVELOPMENT_PHILOSOPHY.md) and [Swift Appendix](./DEVELOPMENT_PHILOSOPHY_APPENDIX_SWIFT.md).

2. **Process for Proposing Changes to `.swiftlint.yml`**:
   - **Step 1**: Create a new branch for your proposed changes.
   - **Step 2**: Modify the `.swiftlint.yml` file with your proposed changes.
   - **Step 3**: In your pull request description, include:
     - A detailed explanation of WHY the change is needed
     - The expected impact on existing code
     - How the change aligns with our Development Philosophy
     - Examples of code that would benefit from or be affected by the change
   - **Step 4**: Request reviews from at least two team members, including one senior engineer.
   - **Step 5**: Address feedback and iterate as needed.
   - **Approval Criteria**: Changes will be evaluated based on:
     - Alignment with Development Philosophy
     - Impact on developer productivity vs. code quality
     - Consistency with Swift best practices
     - Balance between strictness and practicality

3. **Disabling Rules**:
   - Use of `swiftlint:disable` comments in code is **strongly discouraged** and considered a last resort.
   - If you feel a rule needs to be disabled for a specific case:
     - **First Option**: Refactor the code to comply with the rule.
     - **Second Option**: Propose a change to the global rule configuration if appropriate.
     - **Last Resort**: If disabling is absolutely necessary:
       ```swift
       // swiftlint:disable:next rule_name - JUSTIFICATION: Detailed explanation of why this exception is necessary and why refactoring isn't possible
       ```
     - The justification MUST include:
       - Why refactoring isn't possible or practical
       - Why this is an exceptional case
       - Why this doesn't compromise code quality or maintenance
   - **Review Process**: All `swiftlint:disable` usage requires:
     - Explicit approval during code review
     - Sign-off from a senior engineer
     - Documentation in the PR description

4. **Rule Disagreements**:
   - If you disagree with a particular rule or its severity, the appropriate channel is to propose a change to `.swiftlint.yml` via pull request, not to disable the rule in your code.
   - Temporary disagreements should be discussed in team meetings or designated Slack channels rather than being resolved through code comments.

### Troubleshooting

- **SwiftLint not running during build**: Ensure the SwiftLint build tool plugin is properly configured in your target's build phases.
- **CI failing but local build passes**: The CI pipeline automatically uses the same SwiftLint version as defined in the project's Package.resolved file. If you're running SwiftLint commands manually, make sure you're using this same version.
- **Unexpected rule behavior**: Check the [SwiftLint documentation](https://github.com/realm/SwiftLint) for the specific rule causing issues.

### Pre-commit Hook Setup

The project includes a pre-commit hook for SwiftLint that provides immediate feedback before code is committed. To set it up:

1. **Install pre-commit**:
   ```bash
   brew install pre-commit
   ```

2. **Install the hooks**:
   ```bash
   cd /path/to/scry-ios
   pre-commit install
   ```

3. **Usage**: After installation, the pre-commit hook will:
   - Automatically run on `git commit`
   - Check staged Swift files with SwiftLint
   - Attempt to auto-fix issues where possible
   - Block commits with unfixable errors
   
4. **Emergency Bypass Procedures (Restricted)**:
   
   **POLICY**: Bypassing pre-commit hooks using `--no-verify` is **STRICTLY FORBIDDEN** under normal circumstances. All issues must be fixed locally before committing.
   
   In documented emergency situations only, the following procedure must be followed:
   
   - **Prior Approval**: Obtain explicit approval from a senior engineer.
   - **Ticket Requirement**: The bypass must be linked to a documented emergency in the issue tracking system.
   - **Commit Message**: The commit message MUST include:
     1. The emergency ticket/issue number (e.g., `[EMERGENCY-123]`)
     2. The name of the senior engineer who approved the bypass
     3. A detailed justification explaining why fixing the issue locally is not possible
   - **Post-Emergency Documentation**: After the emergency is resolved, document the bypass in the team knowledge base, including root cause and prevention measures.
   
   **IMPORTANT**: All emergency commits that bypass hooks are still subject to code review and MUST pass CI checks. Emergency is not an excuse for quality compromise.
   
   **⚠️ THIS COMMAND IS FOR EMERGENCY USE ONLY ⚠️**
   ```bash
   # EMERGENCY USE ONLY - Requires senior engineer approval and emergency ticket
   git commit -m "[EMERGENCY-123] Commit message with detailed justification and approver name" --no-verify
   ```

### Fallback Plan for SwiftLint Plugin Failures

In case the SwiftLint SPM build tool plugin encounters issues with new Xcode or Swift versions, follow this fallback strategy:

1. **Temporarily Disable the Plugin**:
   - In the target's Build Phases, uncheck the SwiftLint plugin in the "Run Build Tool Plug-ins" phase
   
2. **Add a Run Script Build Phase**:
   - In Xcode, select your target
   - Go to "Build Phases"
   - Click "+" → "New Run Script Phase"
   - Name it "SwiftLint"
   - Move it before the "Compile Sources" phase
   - Add the following script:
     ```bash
     export PATH="$PATH:/opt/homebrew/bin"
     if which swiftlint > /dev/null; then
       swiftlint --config "${SRCROOT}/.swiftlint.yml"
     else
       echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
     fi
     ```

3. **Ensure Correct SwiftLint Version**:
   - Check Package.resolved for the current SwiftLint version
   - Install that specific version:
     ```bash
     brew uninstall swiftlint
     brew install swiftlint@[version]
     # Or download the specific release from GitHub and install manually
     ```

4. **Report the Issue**:
   - Create an issue in the [SwiftLint GitHub repository](https://github.com/realm/SwiftLint)
   - Include details about the Xcode and Swift versions causing problems
   - Link to the issue in our project management system

5. **Monitor for Updates**:
   - Watch for SwiftLint releases that address the issue
   - Once resolved, remove the run script and re-enable the plugin

This fallback ensures continuous code quality enforcement even when plugin infrastructure has compatibility issues with new toolchain releases.

### References

- [SwiftLint GitHub Repository](https://github.com/realm/SwiftLint)
- [SwiftLint Rules Directory](https://realm.github.io/SwiftLint/rule-directory.html)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [pre-commit Framework](https://pre-commit.com/)