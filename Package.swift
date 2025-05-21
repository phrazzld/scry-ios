// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ScryiOS",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.55.1"),
    ],
    targets: [
        .executableTarget(
            name: "ScryiOS",
            path: "ScryiOS",
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        )
    ]
)