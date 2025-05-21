# Plan: Setup and Enforce SwiftLint with Shared Configuration for Scry iOS App

## Chosen Approach (One‑liner)

Integrate SwiftLint as a Swift Package Manager (SPM) build tool plugin, enforced during Xcode builds with a strict, shared `.swiftlint.yml`, and backed by CI checks, making it the non-negotiable standard for code style and quality.

## Architecture Blueprint

-   **Modules / Packages**
    -   **SwiftLint (External SPM Package)** → Provides linting capabilities and the `SwiftLintPlugin` build tool plugin.
    -   **ScryiOS (Main App Target)** → Consumes the `SwiftLintPlugin`.
    -   **`.swiftlint.yml` (Configuration File)** → Single source-of-truth for all SwiftLint rules, version-controlled at the project root.
-   **Public Interfaces / Contracts**
    -   **`.swiftlint.yml`**: YAML configuration defining enabled/disabled rules, thresholds, and custom configurations.
    -   **SwiftLintPlugin (Build Tool Plugin)**: Invoked by Xcode during the build process. Reads `.swiftlint.yml` and lints modified/all files.
    -   **CI Job Step**: Executes SwiftLint (e.g., `swiftlint lint --strict`) to validate all code.
-   **Data Flow Diagram**
    ```mermaid
    graph LR
        subgraph LocalDevelopment
            A[Developer Modifies/Adds Code] --> B{Xcode Build};
            B -- Triggers --> C[SwiftLintPlugin (Build Tool)];
            D[project.pbxproj/Package.swift] -- Defines Dependency & Plugin Use --> C;
            E[.swiftlint.yml] -- Provides Rules --> C;
            C -- Linting Results (Errors/Warnings) --> B;
            B -- Reports to Developer --> F[Developer Fixes Issues or Build Fails];
        end

        subgraph ContinuousIntegration
            G[Code Pushed to Repository] --> H{CI Pipeline Triggered};
            H --> I[Checkout Code];
            I --> J[SwiftLint Command (e.g., swiftlint lint --strict)];
            E[.swiftlint.yml] -- Provides Rules --> J;
            J -- Linting Results --> K{Violations Found?};
            K -- Yes --> L[CI Build Fails];
            K -- No --> M[CI Build Proceeds];
        end
    ```
-   **Error & Edge‑Case Strategy**
    -   **Lint Violations (Local Build)**: Configured to surface as Xcode errors, failing the build. This provides immediate feedback.
    -   **Lint Violations (CI Build)**: SwiftLint command exits non-zero, failing the CI job, preventing merge of non-compliant code.
    -   **SwiftLint Tool/Plugin Failure**: Build process fails, indicating an issue with the SwiftLint installation or plugin configuration.
    -   **Missing `.swiftlint.yml`**: SwiftLint might use default rules or fail. The file *must* be version-controlled and present at the project root.
    -   **Inconsistent SwiftLint Version**: Managed by SPM (`Package.resolved`) ensuring all developers and CI use the same version of the plugin. If `swiftlint` CLI is used in CI, its version should be pinned.

## Detailed Build Steps

1.  **Add SwiftLint Package Dependency**:
    *   In Xcode: `File > Add Packages...`
    *   Enter the SwiftLint repository URL: `https://github.com/realm/SwiftLint.git`
    *   Set "Dependency Rule" to "Up to Next Major Version" or a specific version (e.g., `0.55.1` or newer).
    *   Add the package to the main application target (e.g., "Scry").
    *   **Rationale**: Integrates SwiftLint into the project using SPM, allowing access to its build tool plugin.

2.  **Apply SwiftLintPlugin to Target**:
    *   Select the main application target (e.g., "Scry") in the Xcode project editor.
    *   Go to the "Build Phases" tab.
    *   In the "Run Build Tool Plug-ins" phase, click the "+" button and add `SwiftLintPlugin`.
    *   **Rationale**: Configures Xcode to automatically run SwiftLint on the target's source files during each build.

3.  **Create and Configure `.swiftlint.yml`**:
    *   Create a file named `.swiftlint.yml` at the project root directory.
    *   Populate with a comprehensive set of rules aligned with Swift best practices and `DEVELOPMENT_PHILOSOPHY.md`. Prioritize strictness, readability, and maintainability.
    *   **Initial `.swiftlint.yml` (Baseline - adapt as needed)**:
        ```yaml
        # DEVELOPMENT_PHILOSOPHY.md: Simplicity, Modularity, Separation, Testability, Coding Standards.
        # Strict by default, favoring explicit configurations.

        opt_in_rules: # Explicitly opt-in to non-default rules
          - array_init
          - attributes # Ensure @objc attributes are on the same line for clarity
          - closure_body_length
          - closure_end_indentation
          - closure_spacing
          - collection_alignment
          - discouraged_object_literal # Prefer initializers
          - discouraged_optional_boolean # Use non-optional Booleans
          - empty_collection_literal
          - empty_count # Use .isEmpty over .count == 0
          - empty_string
          - enum_case_associated_values_count
          - explicit_acl # Be explicit about access control
          - explicit_enum_raw_value # Prefer explicit raw values
          - explicit_init
          - explicit_self # Enforce explicit self in closures with [weak self]
          - explicit_type_interface # For public interfaces
          - extension_access_modifier # Consistent access modifiers for extensions
          - fallthrough # Discourage fallthrough
          - fatal_error_message # Ensure fatalError has a descriptive message
          - file_header # Define a project file header template if desired
          - file_name_no_space
          - first_where # Prefer .first(where:) over .filter { }.first
          - force_unwrapping # SEVERITY: error. PHILOSOPHY: Avoid unless invariant guarantees.
          - function_default_parameter_at_end
          - identical_operands
          - implicitly_unwrapped_optional # SEVERITY: error. PHILOSOPHY: Avoid.
          - inert_defer
          - joined_default_parameter
          - last_where # Prefer .last(where:) over .filter { }.last
          - let_var_whitespace
          - literal_expression_end_indentation
          - lower_acl_than_parent
          - modifier_order # Consistent order for modifiers
          - multiline_arguments
          - multiline_function_chains
          - multiline_literal_brackets
          - multiline_parameters
          - multiline_parameters_brackets
          - nimble_operator # If using Nimble
          - no_extension_access_modifier # If `explicit_acl` for extensions is preferred
          - no_fallthrough_only_cases
          - nslocalizedstring_key
          - number_separator # Improve readability of large numbers
          - object_literal # Prefer initializers for UIColor, UIImage, etc.
          - operator_usage_whitespace
          - overridden_super_call # Ensure super is called when overriding
          - override_realm_long_type # If using Realm
          - prefer_self_type_over_type_of_self
          - private_action # @IBAction should be private or fileprivate
          - private_outlet # @IBOutlet should be private or fileprivate
          - private_over_fileprivate # Prefer private unless fileprivate is strictly needed
          - private_unit_test # Test classes and methods should be internal or public
          - prohibited_interface_builder # Discourage IB if code-based UI is standard
          - prohibited_super_call # Ensure super is not called where it shouldn't be
          - quick_discouraged_call # If using Quick
          - quick_discouraged_focused_test # If using Quick
          - quick_discouraged_pending_test # If using Quick
          - raw_value_for_camel_cased_codable_enum
          - redundant_nil_coalescing
          - redundant_objc_attribute
          - redundant_optional_initialization
          - redundant_setters_for_computed_properties
          - redundant_type_annotation
          - redundant_void_return
          - single_test_class
          - sorted_first_last # Prefer min()/max() over sorted().first/last
          - sorted_imports # Keep imports sorted
          - static_operator
          - strong_iboutlet # Use strong for IBOutlets (default behavior now)
          - switch_case_on_newline
          - test_case_accessibility
          - toggle_bool
          - trailing_closure
          - type_contents_order # Define a consistent order for type members
          - unhandled_throwing_task # Ensure Task results/errors are handled
          - unneeded_break_in_switch
          - unneeded_parentheses_in_closure_argument
          - untyped_error_in_catch
          - unused_capture_list
          - vertical_whitespace_between_cases
          - vertical_whitespace_closing_braces
          - vertical_whitespace_opening_braces
          - void_return # Prefer `-> Void` over `-> ()`
          - xct_specific_matcher # Use XCTest specific matchers

        disabled_rules:
          - todo # Allow TODOs for now; can be changed to error later
          # - identifier_name # Often too restrictive; configure carefully if enabled
          # - type_name # Often too restrictive; configure carefully if enabled

        analyzer_rules: # More complex, potentially slower rules
          - explicit_self

        # Rule Configurations (Adjust thresholds based on project needs and DEVELOPMENT_PHILOSOPHY)
        cyclomatic_complexity:
          warning: 15
          error: 25 # PHILOSOPHY: Signals need for refactoring
        file_length:
          warning: 500
          error: 700 # PHILOSOPHY: Encourage modularity and conciseness
        function_body_length:
          warning: 60
          error: 100 # PHILOSOPHY: Encourage focused functions
        function_parameter_count:
          warning: 5
          error: 7
        type_body_length:
          warning: 300
          error: 500 # PHILOSOPHY: Encourage focused types
        line_length:
          warning: 140 # Balance readability with screen real estate
          error: 160
        nesting:
          type_level:
            warning: 3
            error: 5
          statement_level:
            warning: 5
            error: 7
        identifier_name: # PHILOSOPHY: Meaningful naming, Swift API Design Guidelines
          min_length:
            error: 3 # Allow short names like 'id', 'vc', 'vm' in very local scope
          max_length:
            warning: 60
            error: 80
          excluded: # Common initialisms or allowed short names
            - id
            - URL
            - key
            - lhs
            - rhs
            - T # For generics
            - U # For generics
            - V # For generics
        custom_rules:
          no_print: # DEVELOPMENT_PHILOSOPHY.md: No `print()` statements in production code.
            name: "No Print Statements"
            message: "Use a proper logging framework instead of print()."
            regex: "print\\s*\\("
            severity: error
          # Add more custom rules as needed, e.g., for specific architectural patterns.
        ```
    *   **Rationale**: This file is the single source of truth for linting rules. Starting with a comprehensive and strict set enforces quality from the outset. Comments explain rule choices.

4.  **Verify Local Integration**:
    *   Clean and build the project in Xcode (`Cmd+Shift+K`, then `Cmd+B`).
    *   Intentionally introduce a lint violation (e.g., a `print("test")` statement or a long line).
    *   Build again. Verify that Xcode shows an error for the violation and the build fails.
    *   Fix the violation and verify the build succeeds.
    *   **Rationale**: Ensures the plugin is correctly configured and provides immediate feedback to developers.

5.  **Integrate SwiftLint into CI Workflow**:
    *   In your CI configuration file (e.g., GitHub Actions workflow `.yml`):
        *   Ensure Swift (matching project version) is available.
        *   Install SwiftLint CLI if not using a pre-built environment with it. The version should match or be compatible with the SPM plugin version. Use Homebrew: `brew install swiftlint` or download a specific release.
        *   Add a script step to run SwiftLint:
            ```bash
            if ! swiftlint version | grep -q "$(grep 'swiftlint/swiftlint' Package.resolved | sed -n 's/.*"version": "\(.*\)",/\1/p')"; then
              echo "CI SwiftLint CLI version does not match Package.resolved. Please update."
              # Optionally, install the correct version here or fail.
            fi
            swiftlint lint --strict --config .swiftlint.yml
            ```
            (The version check script is an advanced step; simpler is to pin the CLI install version.)
            Alternatively, if CI environment allows running SPM plugins: `swift build --target ScryiOS` (or similar command that triggers build tool plugins). However, a direct `swiftlint lint` is often more straightforward for CI.
    *   **Rationale**: CI acts as the ultimate gatekeeper, ensuring no code violating linting rules is merged. `--strict` treats warnings as errors.

6.  **Document SwiftLint Usage**:
    *   Update `README.md` or create `CONTRIBUTING.md` / `docs/code_quality.md` with:
        *   Purpose of SwiftLint (code quality, consistency).
        *   How it's integrated (SPM plugin, automatic on build).
        *   Link to the official SwiftLint rules documentation.
        *   Project's policy on `.swiftlint.yml` (changes via PR, rationale required).
        *   Strict policy on `swiftlint:disable` comments (discouraged; require strong justification and approval, include a comment explaining *why*).
        *   Troubleshooting tips (e.g., if plugin doesn't run, ensure it's in "Run Build Tool Plug-ins").
    *   **Rationale**: Ensures all developers understand the tooling, its importance, and how to work with it.

7.  **(Optional but Recommended) Setup Pre-commit Hooks**:
    *   Install `pre-commit` (`pip install pre-commit` or `brew install pre-commit`).
    *   Create `.pre-commit-config.yaml` in the project root:
        ```yaml
        repos:
          - repo: https://github.com/realm/SwiftLint
            rev: 0.55.1 # Pin to the same version as SPM or a compatible one
            hooks:
              - id: swiftlint
                args: [--fix, --config, .swiftlint.yml] # Auto-fix simple issues
        ```
    *   Run `pre-commit install` to set up the git hooks.
    *   **Rationale**: Provides even earlier feedback to developers before code is even committed locally, reducing CI failures. `--fix` can improve developer experience.

## Testing Strategy

-   **Test Layers**:
    -   **Integration Testing (Local Build)**: Verifying that the SwiftLint SPM plugin correctly integrates with the Xcode build process.
        *   Test: Introduce a lint violation -> Build fails with an error in Xcode.
        *   Test: Fix violation -> Build succeeds.
        *   Test: Ensure plugin runs for relevant files.
    -   **Integration Testing (CI)**: Verifying that the CI job correctly runs SwiftLint and fails the build on violations.
        *   Test: Push code with a lint violation -> CI build fails at the linting step.
        *   Test: Push compliant code -> CI build passes the linting step.
-   **What to mock**: N/A. SwiftLint is a static analysis tool operating on source code. Testing involves real code and the real SwiftLint tool/plugin.
-   **Coverage targets & edge‑case notes**:
    -   SwiftLint should cover 100% of the project's Swift source files (excluding explicitly ignored paths in `.swiftlint.yml`, like third-party code or generated files).
    -   Edge cases: Files with many violations, complex rule interactions, newly added files not being picked up (unlikely with SPM plugin).

## Logging & Observability

-   **Log events + structured fields per action**:
    -   **Local Builds**: SwiftLint violations are reported directly in Xcode's issue navigator (file, line, message, rule ID).
    -   **CI Builds**: SwiftLint CLI output (stdout/stderr) is captured by the CI system's logging. This output includes file paths, line numbers, rule IDs, and violation messages.
-   **Correlation ID propagation**: N/A for this linting tool.

## Security & Config

-   **Input validation hotspots**: N/A. SwiftLint analyzes source code, not runtime inputs.
-   **Secrets handling**: The `.swiftlint.yml` configuration file must NOT contain any secrets. It is version-controlled and shared.
-   **Least‑privilege notes**:
    -   The SwiftLint plugin runs with the same permissions as the Xcode build process.
    -   The SwiftLint CLI in CI runs with the permissions of the CI runner. It only requires read access to source code files.

## Documentation

-   **Code self‑doc patterns**:
    -   The `.swiftlint.yml` file itself should be well-commented, especially for custom rules or non-obvious configurations, explaining the rationale.
    -   Enforced rules (e.g., for naming, complexity, length) indirectly promote more readable and self-documenting code.
-   **Required readme or openapi updates**:
    -   Update `README.md` (or a dedicated `CONTRIBUTING.md` / `docs/code_quality.md`):
        *   Section on "Code Quality & Linting".
        *   Rationale for using SwiftLint (alignment with `DEVELOPMENT_PHILOSOPHY.md`).
        *   Confirmation that SwiftLint runs automatically during Xcode builds via SPM plugin.
        *   Instructions for CI integration (if developers need to understand CI failures).
        *   Link to the project's `.swiftlint.yml` and official SwiftLint rule documentation.
        *   Policy on rule changes (via PR, with justification).
        *   Strict policy on `swiftlint:disable` (strongly discouraged, requires justification and approval).
        *   (If pre-commit hooks are implemented) Instructions for installing and using `pre-commit`.

## Risk Matrix

| Risk                                                              | Severity | Mitigation                                                                                                                                                              |
| :---------------------------------------------------------------- | :------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Developers find linting too restrictive / slows development       | Medium   | Start with a balanced `.swiftlint.yml`, iterate based on team feedback. Clearly document rationale for rules. Emphasize long-term quality benefits. Use `--fix` where possible. |
| Inconsistent SwiftLint version between SPM plugin and CI CLI      | Medium   | Pin SwiftLint CLI version in CI to match SPM plugin version. Add a CI check (as in Detailed Steps) to verify version alignment.                                         |
| Build times increase significantly due to linting                 | Low      | SwiftLint is generally fast. Monitor build times. If it becomes an issue, investigate incremental linting options or optimize rules (e.g., disable very slow analyzer rules if not critical). |
| `.swiftlint.yml` becomes outdated or unmaintained                 | Medium   | Assign ownership for maintaining the linting configuration. Regularly review and update rules as Swift or project practices evolve. Changes via PR with review.         |
| Developers bypass local linting (e.g., disabling plugin locally)  | High     | CI pipeline is the ultimate gatekeeper and must enforce SwiftLint strictly. Pre-commit hooks add another layer of local enforcement.                                |
| SwiftLint plugin issues or bugs with new Xcode/Swift versions     | Medium   | Keep SwiftLint package updated. Monitor SwiftLint GitHub issues. Have a fallback plan (e.g., temporary Run Script phase) if plugin breaks critically.                |
| Misconfiguration of `.swiftlint.yml` leading to incorrect linting | Low      | Test configuration changes thoroughly. Review `.swiftlint.yml` changes carefully in PRs.                                                                                |

## Open Questions

-   What is the definitive initial set of rules for `.swiftlint.yml`? (Provided a strong baseline; needs team review and potential adjustment for Scry-specific needs).
-   What is the agreed-upon process for proposing and approving changes to `.swiftlint.yml`? (Suggested: PR with rationale and team review).
-   Are there any existing codebases or generated files that need to be explicitly excluded in `.swiftlint.yml` from the outset?
-   Will the optional pre-commit hook setup be implemented as part of this initial task or as a follow-up? (Recommended to include if time permits for better DX).