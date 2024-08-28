import Foundation

/**
 # Links:
 - https://firebase.google.com/docs/analytics/get-started?platform=ios

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import class FirebaseAnalytics.Analytics
 import Tracker

 extension Analytics: FirebaseAnalyticsServiceAdapter {}
 ```
 */

public protocol FirebaseAnalyticsServiceAdapter {
    // swiftlint:disable:next discouraged_optional_collection
    static func logEvent(_ name: String, parameters: [String: Any]?)
    static func setAnalyticsCollectionEnabled(_ enabled: Bool)
    static func setUserID(_ userId: String?)
    static func setUserProperty(_ value: String?, forName: String)
}
