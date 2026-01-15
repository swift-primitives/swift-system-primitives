// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-system-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "System Primitives",
            targets: ["System Primitives"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "System Primitives",
            dependencies: []
        ),
        .testTarget(
            name: "System Primitives Tests",
            dependencies: [
                "System Primitives",
            ],
            path: "Tests/System Primitives Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .strictMemorySafety(),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
