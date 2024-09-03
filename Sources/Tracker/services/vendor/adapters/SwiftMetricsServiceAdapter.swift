import Foundation

/**
 # Links:
 - https://github.com/apple/swift-metrics

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/apple/swift-metrics", "1.0.0" ..< "3.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies: [.product(name: "Metrics", package: "swift-metrics"),
     ]
 )
 ```

 # Integration example:
 ```
 import Logging
 import Tracker

 extension Logger: SwiftMetricsServiceAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol SwiftMetricsServiceAdapter {
    static func incrementCounter(_ label: String,  dimensions: [(String, String)])
}
