import Foundation

/**
 # Links:
 - https://github.com/taplytics/taplytics-ios-sdk/blob/master/START.md

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/taplytics/taplytics-ios-sdk", from: "4.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Taplytics", package: "taplytics-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import class Taplytics.Taplytics
 import Tracker

 extension Taplytics: TaplyticsServiceAdapter {}
 ```
 */

public protocol TaplyticsServiceAdapter {
    static func hasUserOptedOutTracking() -> Bool
    static func logEvent(_ eventName: String)
    static func optOutUserTracking()
    static func optInUserTracking()
    static func setUserAttributes(_ attributes: [AnyHashable: Any]?)
}
