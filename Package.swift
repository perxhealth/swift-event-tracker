// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "EventTracker",
    platforms: [
        .iOS("8.0"),
        .macOS("10.9"),
        .watchOS("2.0"),
        .tvOS("9.0"),
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
