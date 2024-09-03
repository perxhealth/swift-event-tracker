import Foundation

/**
 # Links:
 - https://github.com/dankinsoid/swift-analytics

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/dankinsoid/swift-analytics", from: "1.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "SwiftAnalytics", package: "swift-analytics"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 A reference implementation of the `SwiftAnalyticsServiceAdapter` is provided by the **SwiftAnalyticsTracking** product.
 */

// sourcery: AutoMockable
public protocol SwiftAnalyticsServiceAdapter {
    func send(_ event: String, parameters: [String: String])
    mutating func setParameter(name: String, value: String)
    mutating func resetParameters()
}
