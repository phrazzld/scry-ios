# BACKLOG

## High Priority

### Foundational Setup & Tooling
- [x] **[Chore] [PHILOSOPHY-CRITICAL]: Standardize and Update to Current Stable Swift Version**
  - **Complexity**: Small
  - **Rationale**: Ensures the project leverages modern Swift features, benefits from compiler improvements, and maintains better security and compatibility, aligning with "Tooling and Environment" and "Coding Standards". This is crucial for long-term project health and developer efficiency.
  - **Expected Outcome**: Project configured to use the latest stable Swift version supported by the team's primary Xcode, with this version documented.
  - **Dependencies**: None

- [x] **[Chore] [PHILOSOPHY-HIGH]: Configure Project for Correct Code Signing (Development Team ID)**
  - **Complexity**: Small
  - **Rationale**: Essential for enabling app deployment on physical devices for testing and preparing for future distribution. Aligns with "Security (Build Integrity)" and "Tooling and Environment".
  - **Expected Outcome**: Xcode project's build settings correctly configured with a valid Apple Development Team ID and appropriate provisioning for development builds.
  - **Dependencies**: None

- [x] **[Chore] [PHILOSOPHY-LOW]: Add `.xcode-version` File for Xcode Version Consistency**
  - **Complexity**: Small
  - **Rationale**: Reduces "works on my machine" issues and ensures a consistent development environment for all team members and CI. Aligns with "Tooling and Environment". (Elevated to High due to its foundational nature for team consistency).
  - **Expected Outcome**: An `.xcode-version` file in the project root specifying the exact Xcode version to be used.
  - **Dependencies**: [PHILOSOPHY-CRITICAL] Standardize Swift Version (as Xcode version dictates Swift compatibility)

### Code Quality & Standards
- **[Chore] [PHILOSOPHY-CRITICAL]: Setup and Enforce SwiftLint with Shared Configuration**
  - **Complexity**: Medium
  - **Rationale**: Enforces mandatory coding standards and automation principles, leading to higher code quality, fewer bugs, and improved developer productivity. This is foundational for a maintainable codebase.
  - **Expected Outcome**: Consistent code style, early detection of potential bugs, and improved code quality. SwiftLint integrated into build process and CI via a shared `.swiftlint.yml`.
  - **Dependencies**: None

- **[Chore] [PHILOSOPHY-CRITICAL]: Setup and Enforce Code Formatting Standard (e.g., SwiftFormat)**
  - **Complexity**: Medium
  - **Rationale**: Enforces uniform code appearance and readability (Formatting is Non-Negotiable), reducing cognitive load and style debates. Aligns with "Coding Standards" and "Automation".
  - **Expected Outcome**: Uniform code appearance, reduced style debates, and improved readability. Formatter (e.g., SwiftFormat with `.swiftformat` config) integrated into pre-commit hooks and CI.
  - **Dependencies**: None

- **[Refactor] [PHILOSOPHY-LOW]: Apply `final` Keyword to Non-Inheritable Application Classes**
    - **Complexity**: Small
    - **Rationale**: Improves code clarity by explicitly stating design intent, prevents unintended subclassing, and can offer minor compiler optimizations. Aligns with "Simplicity" and "Coding Standards". (Elevated to High as an early good practice).
    - **Expected Outcome**: Application-specific classes not designed for inheritance are marked `final`.
    - **Dependencies**: Initial class definitions (e.g., AppDelegate, SceneDelegate)

### Architecture & Design
- **[Refactor] [PHILOSOPHY-HIGH]: Define, Document, and Apply Initial Architectural Pattern (e.g., MVVM-C, TCA)**
  - **Complexity**: Large
  - **Rationale**: Establishes a clear, scalable, and testable architecture from the outset, promoting separation of concerns, modularity, and maintainability. This is critical for the long-term health and evolution of the application.
  - **Expected Outcome**: A standard iOS architectural pattern selected and documented. Initial components (e.g., `ContentView`, app setup) refactored to align. New architecture-specific folders/files created.
  - **Dependencies**: None

- **[Enhancement] [PHILOSOPHY-HIGH]: Establish and Implement Basic Dependency Injection Mechanism**
  - **Complexity**: Medium
  - **Rationale**: Decouples components, making them easier to test in isolation, replace, and maintain, aligning with "Dependency Inversion Principle" and "Design for Testability". This is crucial for a flexible and testable architecture.
  - **Expected Outcome**: A consistent approach for dependency injection (e.g., constructor injection) implemented and used in core application components and ViewModels.
  - **Dependencies**: [PHILOSOPHY-HIGH] Define Architectural Pattern

- **[Refactor] [PHILOSOPHY-LOW]: Clarify and Standardize Application Entry Point (AppDelegate vs. SwiftUI App)**
    - **Complexity**: Small
    - **Rationale**: Ensures a clear, unambiguous application launch and lifecycle management structure, aligning with "Simplicity" and "Explicit is Better than Implicit". (Elevated to High for foundational clarity).
    - **Expected Outcome**: A single, primary approach for app lifecycle management chosen and implemented; redundant setup removed or reconciled; decision documented.
    - **Dependencies**: None

### CI/CD & Automation
- **[Chore] [PHILOSOPHY-HIGH]: Implement Core CI Pipeline (Lint, Format, Build, Test)**
  - **Complexity**: Medium
  - **Rationale**: Automates quality assurance, providing rapid feedback on code changes, preventing regressions, and ensuring standards are met before merging. Aligns with "Automate Everything" and "Quality Gates".
  - **Expected Outcome**: A Continuous Integration pipeline (e.g., GitHub Actions) configured to run linters, formatters, build the application, and execute tests on every push and pull request.
  - **Dependencies**: [PHILOSOPHY-CRITICAL] Setup SwiftLint, [PHILOSOPHY-CRITICAL] Setup Code Formatter, [PHILOSOPHY-CRITICAL] Create Test Targets

- **[Chore] [PHILOSOPHY-HIGH]: Implement Pre-commit Hooks for Local Linting and Formatting**
  - **Complexity**: Medium
  - **Rationale**: Enforces code quality checks locally before code enters the repository, improving developer workflow and code hygiene. Aligns with "Automate Everything" and "Quality Gates".
  - **Expected Outcome**: Local pre-commit hooks (e.g., using `pre-commit` framework) set up to automatically run SwiftLint and the chosen code formatter.
  - **Dependencies**: [PHILOSOPHY-CRITICAL] Setup SwiftLint, [PHILOSOPHY-CRITICAL] Setup Code Formatter

### Testing & Quality Assurance
- **[Chore] [PHILOSOPHY-CRITICAL]: Create Initial Unit and UI Test Targets with Basic Structure**
  - **Complexity**: Small
  - **Rationale**: Establishes the foundation for automated testing, which is crucial for verifying functionality, preventing regressions, and enabling safe refactoring. Aligns with "Design for Testability" and "Testing Strategy".
  - **Expected Outcome**: Dedicated XCTest Unit Test and UI Test targets added to the Xcode project, with a basic file structure for future tests.
  - **Dependencies**: None

### Logging & Observability
- **[Refactor] [PHILOSOPHY-CRITICAL]: Eradicate `print()` Statements for Operational Logging**
  - **Complexity**: Small
  - **Rationale**: Adheres to logging standards (`print()` is FORBIDDEN for operational logs), preventing unintentional exposure of debug information and preparing for robust, structured logging.
  - **Expected Outcome**: All instances of `print()` used for debugging or operational logging removed from the application codebase.
  - **Dependencies**: None (but precedes structured logging implementation)

- **[Enhancement] [PHILOSOPHY-HIGH]: Implement Structured Logging System (e.g., OSLog, SwiftLog)**
  - **Complexity**: Medium
  - **Rationale**: Provides standardized, efficient, and filterable logging suitable for effective debugging and monitoring, aligning with "Logging Strategy (Structure, Context)" and "Observability".
  - **Expected Outcome**: A robust structured logging framework integrated and configured for appropriate log levels and output formats.
  - **Dependencies**: [PHILOSOPHY-CRITICAL] Eradicate `print()` Statements

### Build & Configuration Management
- **[Chore] [PHILOSOPHY-HIGH]: Implement Build Configuration Management using .xcconfig Files**
  - **Complexity**: Medium
  - **Rationale**: Provides consistent, manageable, and environment-specific build settings, improving build reliability and flexibility for different stages (Debug, Release). Aligns with "Configuration Management" and "Externalization".
  - **Expected Outcome**: `.xcconfig` files created and integrated to manage build settings for different environments, externalizing settings like bundle identifiers and API endpoint placeholders.
  - **Dependencies**: None

### Documentation & Knowledge Sharing
- **[Documentation] [PHILOSOPHY-HIGH]: Create Comprehensive Root README.md**
  - **Complexity**: Small
  - **Rationale**: Provides a mandatory central entry point for project information, crucial for onboarding new team members and understanding the project quickly. Aligns with "Documentation Approach".
  - **Expected Outcome**: A `README.md` file at the project root containing project overview, setup instructions, testing guide, chosen architecture summary, and contribution guidelines.
  - **Dependencies**: [PHILOSOPHY-HIGH] Define Architectural Pattern (for architecture summary)

## Medium Priority

### Architecture & Design
- **[Refactor] [PHILOSOPHY-MEDIUM]: Refactor Project Structure for Feature-Based Grouping**
  - **Complexity**: Medium
  - **Rationale**: Improves code discoverability, cohesion within features, and better scalability as the project grows. Aligns with "Modularity" and "Architecture Guidelines".
  - **Expected Outcome**: Xcode project groups and corresponding file system directories reorganized to group files by business feature or domain.
  - **Dependencies**: [PHILOSOPHY-HIGH] Define Architectural Pattern

### CI/CD & Automation
- **[Chore] [PHILOSOPHY-MEDIUM]: Introduce Fastlane for Local Build and Test Automation Tasks**
  - **Complexity**: Medium
  - **Rationale**: Automates repetitive local build and test processes, improving developer efficiency and consistency. Aligns with "Automate Everything" and "Tooling and Environment".
  - **Expected Outcome**: Fastlane initialized in the project with initial lanes for common local development tasks (e.g., building, testing).
  - **Dependencies**: [PHILOSOPHY-CRITICAL] Create Test Targets

- **[Chore] [PHILOSOPHY-LOW]: Setup Automated Changelog Generation from Conventional Commits**
    - **Complexity**: Medium
    - **Rationale**: Automates and standardizes changelog creation, simplifying release notes preparation and communication of changes. Aligns with "Automate Everything" and "Semantic Versioning". (Elevated to Medium for its process improvement value).
    - **Expected Outcome**: Tooling implemented to automatically generate or update a `CHANGELOG.md` file based on Conventional Commit history.
    - **Dependencies**: [PHILOSOPHY-MEDIUM] Adopt Conventional Commits

### Testing & Quality Assurance
- **[Enhancement] [PHILOSOPHY-MEDIUM]: Integrate Test Coverage Reporting into CI Pipeline**
  - **Complexity**: Medium
  - **Rationale**: Provides visibility into test coverage, helping to identify untested code areas and guide testing efforts. Aligns with "Design for Testability (Coverage Enforcement)" and "Quality Gates".
  - **Expected Outcome**: CI pipeline configured to generate code coverage reports after test execution and make these reports accessible.
  - **Dependencies**: [PHILOSOPHY-HIGH] Implement Core CI Pipeline

### Logging & Observability
- **[Documentation] [PHILOSOPHY-MEDIUM]: Define and Document Consistent Error Handling Strategy**
  - **Complexity**: Medium
  - **Rationale**: Establishes robust and predictable error management, improving application stability and debuggability. Aligns with "Error Handling (Consistency, Clarity)".
  - **Expected Outcome**: A project-wide strategy for error handling (e.g., Swift's `Error` protocol, `Result` type, error propagation/presentation patterns) documented and applied.
  - **Dependencies**: None

### Security & Dependency Management
- **[Documentation] [PHILOSOPHY-MEDIUM]: Define and Document Strategy for Managing Secrets**
  - **Complexity**: Small
  - **Rationale**: Establishes a secure and documented method for handling sensitive information (API keys, tokens), reducing risk of accidental exposure. Aligns with "Security (Best Practices)" and "Configuration Management".
  - **Expected Outcome**: The project's strategy for managing secrets documented, potentially involving gitignored `.xcconfig` files or environment variables for CI.
  - **Dependencies**: [PHILOSOPHY-HIGH] Implement Build Configuration Management

- **[Process] [PHILOSOPHY-MEDIUM]: Establish Process for Vetting and Managing SPM Dependencies**
  - **Complexity**: Small
  - **Rationale**: Ensures a consistent and disciplined approach to managing third-party code, reducing risks related to maintenance, licensing, security, and build times. Aligns with "Dependency Management".
  - **Expected Outcome**: A clear documented process for evaluating, adding, and updating Swift Package Manager (SPM) dependencies.
  - **Dependencies**: None

- **[Enhancement] [PHILOSOPHY-MEDIUM]: Integrate Dependency Vulnerability Scanning into CI**
  - **Complexity**: Medium
  - **Rationale**: Automates the detection of security risks introduced by third-party libraries, enabling proactive mitigation. Aligns with "Security (Dependency Management)" and "Automation".
  - **Expected Outcome**: A step added to the CI pipeline to automatically scan SPM dependencies for known security vulnerabilities.
  - **Dependencies**: [PHILOSOPHY-HIGH] Implement Core CI Pipeline, [PHILOSOPHY-MEDIUM] Establish Process for Vetting SPM Dependencies

### Documentation & Knowledge Sharing
- **[Process] [PHILOSOPHY-MEDIUM]: Adopt Conventional Commits Standard for Version Control**
  - **Complexity**: Small
  - **Rationale**: Standardizes commit messages, enabling automated changelog generation, clearer version history, and improved team communication. Aligns with "Coding Standards (Version Control)" and "Semantic Versioning".
  - **Expected Outcome**: The Conventional Commits specification adopted for all commit messages, with guidelines documented in `CONTRIBUTING.md`.
  - **Dependencies**: None

- **[Documentation] [PHILOSOPHY-LOW]: Document UI Framework Choice and Interoperability Guidelines**
  - **Complexity**: Small
  - **Rationale**: Provides clear guidance on UI development choices and standards for the team, ensuring consistency. Aligns with "Documentation Approach" and "UI Development". (Elevated to Medium for early team alignment).
  - **Expected Outcome**: SwiftUI formally documented as the primary UI framework, with basic guidelines for UIKit interoperability if anticipated.
  - **Dependencies**: None

### Accessibility (a11y)
- **[Enhancement] [PHILOSOPHY-MEDIUM]: Implement Basic Accessibility Properties for Initial UI Elements**
  - **Complexity**: Small
  - **Rationale**: Applies foundational accessibility practices from the start, improving usability for a wider range of users and aligning with the "Accessibility (a11y)" principle.
  - **Expected Outcome**: Essential accessibility properties (e.g., `accessibilityLabel`, `accessibilityHint`, `accessibilityTraits`) added to initial UI elements.
  - **Dependencies**: Initial UI elements exist (e.g., in `ContentView.swift`)

## Low Priority

### Documentation & Knowledge Sharing
- **[Documentation] [PHILOSOPHY-LOW]: Add Initial Documentation Comments to Public APIs**
  - **Complexity**: Small
  - **Rationale**: Improves code navigability and understanding for developers, and enables future generation of API documentation. Aligns with "Documentation (Why vs How, Self-documenting code)".
  - **Expected Outcome**: Swift documentation comments (`///`) added to public structs, classes, protocols, methods, and properties in key components.
  - **Dependencies**: Key components are defined.

## Future Considerations

### Technical Excellence & Innovation
- **[Research]**: Explore Advanced State Management Solutions (if initial choice proves limited)
  - **Complexity**: Medium
  - **Rationale**: Proactively assess if more advanced state management (e.g., TCA if not initially chosen, or other reactive frameworks) becomes necessary as complexity grows, ensuring scalability and maintainability.
  - **Expected Outcome**: A document or PoC evaluating alternative state management solutions against project needs.
  - **Dependencies**: Experience with initial architectural pattern.

- **[Enhancement]**: Implement Modularization Strategy (e.g., Swift Packages for Features)
  - **Complexity**: Complex
  - **Rationale**: Further enhance build times, encapsulation, and team scalability by breaking down the app into independent Swift Packages per feature or layer.
  - **Expected Outcome**: Key features or layers extracted into local Swift Packages.
  - **Dependencies**: [PHILOSOPHY-MEDIUM] Refactor Project Structure for Feature-Based Grouping.

### Operational Excellence
- **[Enhancement]**: Set up Performance Monitoring and Alerting
  - **Complexity**: Medium
  - **Rationale**: Proactively identify and address performance bottlenecks (e.g., app startup, screen transitions, network requests) to ensure a smooth user experience.
  - **Expected Outcome**: Integration of a performance monitoring tool (e.g., Firebase Performance, MetricKit) with dashboards and alerts for key metrics.
  - **Dependencies**: Core application features implemented.

- **[Enhancement]**: Implement Comprehensive Analytics Strategy
  - **Complexity**: Medium
  - **Rationale**: To gain insights into user behavior, feature adoption, and identify areas for improvement, driving data-informed product decisions.
  - **Expected Outcome**: An analytics SDK integrated (e.g., Firebase Analytics, Mixpanel) with key user events tracked.
  - **Dependencies**: Core application features implemented.

### Business & Value Delivery (Placeholders for ScryiOS specific features)
- **[Feature]**: Define and Implement Core "Scrying" Feature - MVP
  - **Complexity**: Complex
  - **Rationale**: To deliver the primary unique value proposition of the "ScryiOS" application. (Specifics of "scrying" TBD based on product vision).
  - **Expected Outcome**: A minimal viable version of the core application feature is designed, implemented, and testable.
  - **Dependencies**: All High/Medium priority foundational items.

- **[Feature]**: User Account Management (Registration, Login, Profile)
  - **Complexity**: Complex
  - **Rationale**: To enable personalized experiences, data persistence, and potential future premium features.
  - **Expected Outcome**: Secure user registration, login, and basic profile management functionality.
  - **Dependencies**: Backend infrastructure, [PHILOSOPHY-MEDIUM] Define and Document Strategy for Managing Secrets.
