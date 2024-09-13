import Foundation

/**
 # Links:
 - https://github.com/heap/heap-ios-sdk

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/heap/heap-ios-sdk", from: "9.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Heap", package: "heap-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Heap
 import Tracker

 extension Heap: HeapServiceAdapter {}
 ```
 */
// sourcery: AutoMockable
public protocol HeapServiceAdapter {
    static func setTrackingEnabled(_ trackingEnabled: Bool)
    static func isTrackingEnabled() -> Bool
    static func identify(_ identity: String)
    static func addUserProperties(_ properties: [String: Any])
    static func track( _ event: String, withProperties properties: [AnyHashable: Any]?)
    static func resetIdentity()
}
