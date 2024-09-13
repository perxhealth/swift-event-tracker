import Foundation

/**
 Adapter for the Localytics SDK.

 # Useful links:
 - https://posthog.com/docs/libraries/ios

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/localytics/Localytics-swiftpm.git", from: "6.0.0")
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Localytics", package: "Localytics-swiftpm"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Localytics
 import Tracker

 extension Localytics: LocalyticsServiceAdapter {}
 ```
 */
// sourcery: AutoMockable
public protocol LocalyticsServiceAdapter {
    static func tagEvent(_ eventName: String, attributes: [String: String]?)
    static func tagScreen(_ screenName: String)
    static func setLoggingEnabled(_ loggingEnabled: Bool)
    static func setCustomerId( _ customerId: String?)
    static func setValue(_ value: String?, forIdentifier:String)
    static func isOptedOut() -> Bool
    static func setOptedOut(_ optedOut: Bool)
    static func isPrivacyOptedOut() -> Bool
    static func setPrivacyOptedOut(_ optedOut: Bool)
}
