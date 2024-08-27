// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "EventTracker",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v12),
    ],
    products: [
        .library(
            name: "Tracker",
            targets: ["Tracker"]
        ),
        .library(
            name: "TrackerTesting",
            targets: ["TrackerTesting"]
        ),
    ],
    dependencies: [],
    targets: [
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
