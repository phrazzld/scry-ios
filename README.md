# Scry iOS

Mobile client for Scry on iOS.

## Setup

### Requirements

- Xcode 16.3+
- Swift 6.1
- iOS 15.0+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

### Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/phrazzld/scry-ios.git
   cd scry-ios
   ```

2. Configure code signing:
   - Copy the developer-specific configuration template:
     ```bash
     cp Config/DeveloperSpecific.xcconfig.template Config/DeveloperSpecific.xcconfig
     ```
   - Edit `Config/DeveloperSpecific.xcconfig` and replace `YOUR_APPLE_DEVELOPMENT_TEAM_ID` with your Apple Developer Team ID.
     > You can find your Team ID in the [Apple Developer Portal](https://developer.apple.com/account) under "Membership Details".

3. Generate the Xcode project:
   ```bash
   xcodegen generate
   ```

4. Open the project in Xcode:
   ```bash
   open ScryiOS.xcodeproj
   ```

5. Build and run the app on a simulator or device.

## Project Structure

- **App**: Contains application lifecycle files (`AppDelegate.swift`, `SceneDelegate.swift`)
- **Views**: Contains SwiftUI views starting with `ContentView.swift`
- **Resources**: Contains assets, Info.plist, and other resources

## Build Configurations

- **Development**: Used for development builds with debugging enabled and automatic code signing
- **Distribution**: Used for release builds with optimizations enabled (prepared for future distribution setup)

## Code Signing

The project uses a layered approach to code signing configuration:

- `Config/Base.xcconfig`: Common settings across all configurations
- `Config/Development.xcconfig`: Development-specific settings
- `Config/Distribution.xcconfig`: Distribution-specific settings
- `Config/DeveloperSpecific.xcconfig`: Your personal Team ID (not committed to git)

This approach allows each developer to use their own Apple Developer Team ID without changing the shared project files.

## Troubleshooting

- If you encounter code signing issues, ensure your Apple Developer Team ID is correctly set in `Config/DeveloperSpecific.xcconfig`.
- If Xcode doesn't recognize your device, try restarting both Xcode and your device.
- After making changes to any `.xcconfig` file or `project.yml`, run `xcodegen generate` again to update the Xcode project.