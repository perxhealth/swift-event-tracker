import Foundation

/**
 Adapter for the KochavaMeasurement framework.

 # Useful links:
 - https://support.kochava.com/sdk-integration/ios-sdk-integration/
 - http://support.kochava.com/sdk-integration/ios-sdk-integration/ios-using-the-sdk/

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     platforms: [.iOS(.v13)],
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/Kochava/Apple-SwiftPackage-KochavaMeasurement-XCFramework", from: "8.0.0"),
         .package(url: "https://github.com/Kochava/Apple-SwiftPackage-KochavaNetworking-XCFramework", from: "8.0.0"),
     ],
     targets: [
         .target(
             name: "Example",
             dependencies:  [
                 .product(name: "KochavaMeasurement", package: "Apple-SwiftPackage-KochavaMeasurement-XCFramework"),
                 .product(name: "KochavaNetworking", package: "Apple-SwiftPackage-KochavaNetworking-XCFramework"),
                 "Tracker"
             ]
         )
     ]
 )
 ```

 # Integration example:
 ```
 import KochavaMeasurement
 import Tracker

 struct KochavaAdapter: KochavaServiceAdapter {
     func sendCustomEvent(name: String, infoDictionary: [AnyHashable : Any]?) {
         KochavaMeasurement.Event.sendCustom(
             eventName: name,
             infoDictionary: infoDictionary
         )
     }

     func registerIdentityLink(name: String, identifier: String?) {
         IdentityLink.register(
             name: name,
             identifier: identifier
         )
     }
 }
 ```
 */

// sourcery: AutoMockable
public protocol KochavaServiceAdapter {
    func sendCustomEvent(name: String, infoDictionary: [AnyHashable : Any]?)
    func registerIdentityLink(name: String, identifier: String?)
}
