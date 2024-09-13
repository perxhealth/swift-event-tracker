import Foundation

/**
 Adapter for the Instabug iOS SDK.

 # Useful links:
 - https://docs.instabug.com/docs/ios-set-custom-data

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/Instabug/Instabug-SP", from: "13.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Instabug", package: "Instabug-SP"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Instabug
 import Tracker

 extension Instabug: InstabugServiceAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol InstabugServiceAdapter {
    static func logUserEvent(withName: String)
    static func removeUserAttribute(forKey: String)
    static func setUserAttribute(_ value: String, withKey: String)
}
