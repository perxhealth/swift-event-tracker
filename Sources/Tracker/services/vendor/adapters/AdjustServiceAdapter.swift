import Foundation

/**
 Adapter for the Adjust SDK for iOS.

 # Useful links:
 - https://github.com/adjust/ios_sdk#event-tracking

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/adjust/ios_sdk", from: "5.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies: [.product(name: "AdjustSdk", package: "ios_sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import AdjustSdk
 import Tracker

 extension Adjust: AdjustServiceAdapter {
     public static func trackEvent(_ eventName: String, parameters: [String: String]) {
         guard let event = ADJEvent(eventToken: eventName) else {
             return
         }
         event.setValuesForKeys(parameters)
         Adjust.trackEvent(event)
     }

     public static func setEnabled(_ flag: Bool) {
         if flag {
             Adjust.enable()
         } else {
             Adjust.disable()
         }
     }
 }
 ```
 */

// sourcery: AutoMockable
public protocol AdjustServiceAdapter {
    static func trackEvent(_ eventName: String, parameters: [String: String])
    static func setEnabled(_ flag: Bool)
}
