// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-system-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "System Primitives",
            targets: ["System Primitives"]
        ),
        .library(
            name: "System Primitives Test Support",
            targets: ["System Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-cardinal-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-ordinal-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-memory-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "System Primitives",
            dependencies: [
                .product(name: "Cardinal Primitives", package: "swift-cardinal-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
                .product(name: "Memory Alignment Primitives", package: "swift-memory-primitives"),
            ]
        ),
        .target(
            name: "System Primitives Test Support",
            dependencies: [
                "System Primitives",
                .product(name: "Cardinal Primitives Test Support", package: "swift-cardinal-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "System Primitives Tests",
            dependencies: [
                "System Primitives",
                "System Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
