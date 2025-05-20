# Plan: Configure Project for Correct Code Signing

## Overview
Configure the iOS project with proper code signing to enable app deployment on physical devices for testing and future distribution. This will implement a robust and secure code signing setup using layered `.xcconfig` files managed by XcodeGen, with developer-specific Team IDs stored in a gitignored local override file.

## Architecture Blueprint

- **Configuration Files**:
  - `project.yml`: XcodeGen configuration defining project structure, targets, and references to `.xcconfig` files
  - `Config/Base.xcconfig`: Common build settings shared across all configurations
  - `Config/Development.xcconfig`: Settings specific to development builds, includes Base.xcconfig
  - `Config/Distribution.xcconfig`: Settings for distribution builds (future use)
  - `Config/DeveloperSpecific.xcconfig.template`: Template for developer-specific settings
  - `Config/DeveloperSpecific.xcconfig`: Developer-specific file containing the actual Team ID (gitignored)
  - `.gitignore`: Updated to exclude `Config/DeveloperSpecific.xcconfig`

- **Configuration Hierarchy**:
  - Base settings defined in `Base.xcconfig`
  - Development-specific settings in `Development.xcconfig` (includes Base)
  - Developer-specific Team ID in `DeveloperSpecific.xcconfig` (overrides Development)
  - Distribution settings in `Distribution.xcconfig` (includes Base, for future use)

## Implementation Steps

1. **Create Configuration Directory**:
   - Create a new directory named `Config` at the project root

2. **Create Configuration Files**:
   - `Config/Base.xcconfig`: Common settings for all configurations
   - `Config/Development.xcconfig`: Development build settings with automatic signing
   - `Config/Distribution.xcconfig`: Distribution build settings (for future use)
   - `Config/DeveloperSpecific.xcconfig.template`: Template for local Team ID configuration

3. **Update .gitignore**:
   - Add entry to exclude the developer-specific configuration file

4. **Update project.yml**:
   - Define configurations and link them to .xcconfig files
   - Remove any hardcoded signing settings from project.yml

5. **Developer Documentation**:
   - Add instructions to README.md for setting up code signing
   - Document the process for obtaining and configuring the Team ID

6. **Regenerate Project and Test**:
   - Run xcodegen to generate the Xcode project file
   - Verify signing settings in Xcode
   - Build and deploy to a physical device to validate the configuration

## Detailed Configuration Files

### 1. Base.xcconfig
```xcconfig
// Config/Base.xcconfig
// Common settings for all configurations

PRODUCT_BUNDLE_IDENTIFIER_BASE = com.scry.ScryiOS
CURRENT_PROJECT_VERSION = 1
MARKETING_VERSION = 1.0
// Add other common settings like SWIFT_VERSION, TARGETED_DEVICE_FAMILY etc.
```

### 2. Development.xcconfig
```xcconfig
// Config/Development.xcconfig
#include "Base.xcconfig"
#include? "DeveloperSpecific.xcconfig" // Include if exists, allows local override

PRODUCT_BUNDLE_IDENTIFIER = $(PRODUCT_BUNDLE_IDENTIFIER_BASE).dev
APP_DISPLAY_NAME = ScryiOS Dev

// Default Development Team - will be overridden by DeveloperSpecific.xcconfig
DEVELOPMENT_TEAM = YOUR_TEAM_ID_PLACEHOLDER_SEE_README

CODE_SIGN_STYLE = Automatic
CODE_SIGN_IDENTITY = Apple Development
PROVISIONING_PROFILE_SPECIFIER =
```

### 3. Distribution.xcconfig
```xcconfig
// Config/Distribution.xcconfig
#include "Base.xcconfig"

PRODUCT_BUNDLE_IDENTIFIER = $(PRODUCT_BUNDLE_IDENTIFIER_BASE)
APP_DISPLAY_NAME = ScryiOS

// Team ID and signing for distribution will be handled by CI or specific release procedures.
// DEVELOPMENT_TEAM = <CI_INJECTED_DISTRIBUTION_TEAM_ID>
CODE_SIGN_STYLE = Manual // Typically Manual for App Store/AdHoc
// CODE_SIGN_IDENTITY = Apple Distribution
// PROVISIONING_PROFILE_SPECIFIER = <SPECIFIC_DISTRIBUTION_PROFILE_NAME_OR_UUID>
```

### 4. DeveloperSpecific.xcconfig.template
```xcconfig
// Config/DeveloperSpecific.xcconfig.template
//
// **DO NOT COMMIT DeveloperSpecific.xcconfig TO VERSION CONTROL.**
//
// 1. Copy this file to "Config/DeveloperSpecific.xcconfig".
// 2. Replace "YOUR_APPLE_DEVELOPMENT_TEAM_ID" with your actual Apple Development Team ID.
//    You can find this ID on the Apple Developer Portal (developer.apple.com/account)
//    under "Membership Details" -> "Team ID".
//
// This file provides your local Development Team ID for signing development builds.

DEVELOPMENT_TEAM = YOUR_APPLE_DEVELOPMENT_TEAM_ID
```

### 5. Updated project.yml
```yaml
name: ScryiOS
options:
  # bundleIdPrefix: com.scry # Remove if PRODUCT_BUNDLE_IDENTIFIER is fully set in xcconfigs
  deploymentTarget:
    iOS: 15.0 # Ensure this matches your project needs

configs: # Define project-level configurations
  Development: debug
  Distribution: release

settings: # Project-level settings
  configs: # Link configurations to xcconfig files
    Development: Config/Development.xcconfig
    Distribution: Config/Distribution.xcconfig

targets:
  ScryiOS:
    type: application
    platform: iOS
    sources:
      - path: ScryiOS # Assuming App/, Views/, Resources/ are subdirectories of ScryiOS/
    settings:
      base:
        INFOPLIST_FILE: ScryiOS/Resources/Info.plist
        ASSETCATALOG_COMPILER_APPICON_NAME: AppIcon
      configs:
        Development: {} # Can put overrides specific to Dev for this target here
        Distribution: {} # Can put overrides specific to Dist for this target here
```

## Risk Mitigation

- **Team ID Exposure**: Using gitignored file for developer-specific settings
- **Missing Configuration**: Clear documentation and template for setup
- **Build Consistency**: XcodeGen ensures consistent project generation 
- **Signing Errors**: Automatic signing for development reduces provisioning issues

## Testing Strategy

- **Build Verification**: Successfully generate project and build for physical device
- **Configuration Check**: Verify correct settings in Xcode's build settings
- **Deployment Test**: Install app on physical device to validate signing

## Documentation Updates

- Add detailed setup instructions to README.md
- Include explanation of code signing process and configuration structure
- Document obtaining and configuring Apple Developer Team ID