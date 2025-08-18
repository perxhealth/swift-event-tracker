// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "EventTracker",
    platforms: [
        .iOS(.v16),
        .macOS(.v10_13),
        .watchOS(.v5),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "SwiftAnalyticsKitTracking",
            targets: ["SwiftAnalyticsKitTracking"]
        ),
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
        .package(url: "https://github.com/SwiftyLab/SwiftAnalyticsKit.git", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "SwiftAnalyticsKitTracking",
            dependencies: [
                .product(name: "Analytics", package: "SwiftAnalyticsKit"),
                "Tracker",
            ]
        ),
        .testTarget(
            name: "SwiftAnalyticsKitTrackingTests",
            dependencies: [
                .product(name: "AnalyticsMock", package: "SwiftAnalyticsKit"),
                "SwiftAnalyticsKitTracking",
                "TrackerTesting"
            ]
        ),
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
