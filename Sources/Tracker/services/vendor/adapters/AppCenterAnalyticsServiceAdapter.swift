import Foundation

/**
 Adapter for the AppCenter iOS and macOS SDK.

 # Useful links:
 - https://docs.microsoft.com/en-us/appcenter/sdk/analytics/ios
 - https://docs.microsoft.com/en-us/appcenter/sdk/getting-started/ios

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/microsoft/appcenter-sdk-apple", from: "5.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies: [.product(name: "AppCenterAnalytics", package: "appcenter-sdk-apple"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import AppCenterAnalytics
 import Tracker

 extension Analytics: AppCenterAnalyticsServiceAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol AppCenterAnalyticsServiceAdapter {
    static func pause()
    static func resume()
    static func trackEvent(_ eventName: String, withProperties properties: [String: String]?)
}
