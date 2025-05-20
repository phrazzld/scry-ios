# Tooling Standards

This document outlines the standard tooling versions for the ScryiOS project to ensure a consistent development environment, aligning with "Tooling and Environment" from DEVELOPMENT_PHILOSOPHY.md.

## Xcode

- **Version:** 16.3 (as specified in `.xcode-version` file in project root)
- **Configuration File (Single Source of Truth):** `.xcode-version`
- **Rationale:** Ensures compatibility with the specified Swift version and latest iOS SDK features.
- **Enforcement:** The `.xcode-version` file is used by tools like `xcenv` and CI systems to automatically select the correct Xcode version, reducing "works on my machine" issues.

## Swift

- **Project Swift Version (MSRV):** 6.1
- **Configuration File (Single Source of Truth):** `Config/Base.xcconfig` (setting: `SWIFT_VERSION = 6.1`)
- **Rationale:** Aligns with the latest stable Swift version bundled with Xcode 16.3. This ensures the project leverages modern Swift features, benefits from compiler improvements, and maintains better security and compatibility.