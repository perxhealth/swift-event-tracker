import Foundation

/**
 # Links:
 - https://github.com/SwiftyLab/SwiftAnalyticsKit

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     platforms: [.iOS(.v13)],
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/SwiftyLab/SwiftAnalyticsKit", from: "1.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Analytics", package: "SwiftAnalyticsKit"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 A reference implementation of the `SwiftAnalyticsKitServiceAdapter` is provided by the **SwiftAnalyticsKitTracking** product.
 */

// sourcery: AutoMockable
public protocol SwiftAnalyticsKitServiceAdapter {
    func fire(_ eventName: String, metadata: [String: String])
}
