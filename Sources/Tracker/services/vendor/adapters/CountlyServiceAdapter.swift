import Foundation

/**
 # Links:
 - https://support.count.ly/hc/en-us/articles/360037753511-iOS-watchOS-tvOS-macOS

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/Countly/countly-sdk-ios", from: "24.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Countly", package: "countly-sdk-ios"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Countly
 import Tracker

 extension Countly: CountlyServiceAdapter {
     public func userLogged(in userID: String) {
         self.changeDeviceIDWithoutMerge(userID)
     }

     public func userLoggedOut() {
         self.changeDeviceIDWithoutMerge(nil)
     }
 }

 extension CountlyUserDetails: CountlyUserDetailsAdapter {}
 ```
*/

// sourcery: AutoMockable
public protocol CountlyServiceAdapter {
    func recordEvent(_ eventName: String, segmentation: [String: Any]?)
    func recordView(_ view: String)
    func recordView(_ view: String, segmentation: [String: Any])
    func userLogged(in userID: String)
    func userLoggedOut()
    func giveConsentForAllFeatures()
    func cancelConsentForAllFeatures()
}

// sourcery: AutoMockable
public protocol CountlyUserDetailsAdapter {
    func set(_ key: String, value: String)
    func unSet(_ key: String)
}
