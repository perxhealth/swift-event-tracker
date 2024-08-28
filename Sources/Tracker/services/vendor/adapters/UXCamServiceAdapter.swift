import Foundation

/**
 # Links:
 - https://help.uxcam.com/hc/en-us/categories/115000129131-Developer-Guide

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/uxcam/uxcam-ios-sdk", from: "3.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "UXCam", package: "uxcam-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Tracker
 import class UXCam.UXCam

 extension UXCam: UXCamServiceAdapter {}
 ```
 */

public protocol UXCamServiceAdapter {
    static func logEvent(_ eventName: String, withProperties: [String: Any]?)
    static func optInOverall()
    static func optInOverallStatus() -> Bool
    static func optOutOverall()
    static func setUserIdentity(_ userIdentity: String)
    static func setUserProperty(_ propertyName: String, value: Any)
    static func tagScreenName(_ screenName: String)
}
