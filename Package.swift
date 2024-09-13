// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "EventTracker",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v5),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "SwiftAnalyticsTracking",
            targets: ["SwiftAnalyticsTracking"]
        ),
        .library(
            name: "Tracker",
            targets: ["Tracker"]
        ),
        .library(
            name: "TrackerTesting",
            targets: ["TrackerTesting"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/dankinsoid/swift-analytics.git", from: "1.9.0"),
    ],
    targets: [
        .target(
            name: "SwiftAnalyticsTracking",
            dependencies: [
                .product(name: "SwiftAnalytics", package: "swift-analytics"),
                "Tracker",
            ]
        ),
        .testTarget(
            name: "SwiftAnalyticsTrackingTests",
            dependencies: ["SwiftAnalyticsTracking", "TrackerTesting"]
        ),
        .target(
            name: "Tracker"
        ),
        .target(
            name: "TrackerTesting",
            dependencies: ["Tracker"]
        ),
        .testTarget(
            name: "TrackerTests",
            dependencies: ["Tracker", "TrackerTesting"]
        ),
    ]
)
