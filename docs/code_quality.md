# Code Quality Guidelines

## SwiftLint Integration

Scry iOS uses SwiftLint to enforce code quality standards and consistent style across the codebase. This document outlines how SwiftLint is integrated, how to work with it, and our policies regarding code style.

### How SwiftLint Is Integrated

- **Build-time Integration**: SwiftLint is integrated as a Swift Package Manager build tool plugin. This means it runs automatically during the build process and will fail the build if linting errors are found.

- **CI Integration**: SwiftLint is also part of our CI pipeline, ensuring that all code submitted via pull requests meets our quality standards.

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
   - Changes to the rule configuration should be proposed via pull request with a clear rationale for the change.
   - All rule changes must align with our [Development Philosophy](./DEVELOPMENT_PHILOSOPHY.md) and [Swift Appendix](./DEVELOPMENT_PHILOSOPHY_APPENDIX_SWIFT.md).

2. **Disabling Rules**:
   - Use of `swiftlint:disable` comments in code is strongly discouraged.
   - If you feel a rule needs to be disabled for a specific case:
     - First consider if the code can be refactored to comply with the rule.
     - If disabling is absolutely necessary, add a clear comment explaining WHY the rule is being disabled.
     - All rule disabling requires approval during code review.

3. **Rule Disagreements**:
   - If you disagree with a particular rule or its severity, the appropriate channel is to propose a change to `.swiftlint.yml` via pull request, not to disable the rule in your code.

### Troubleshooting

- **SwiftLint not running during build**: Ensure the SwiftLint build tool plugin is properly configured in your target's build phases.
- **CI failing but local build passes**: Ensure you're using the same version of SwiftLint locally as is used in CI.
- **Unexpected rule behavior**: Check the [SwiftLint documentation](https://github.com/realm/SwiftLint) for the specific rule causing issues.

### References

- [SwiftLint GitHub Repository](https://github.com/realm/SwiftLint)
- [SwiftLint Rules Directory](https://realm.github.io/SwiftLint/rule-directory.html)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)