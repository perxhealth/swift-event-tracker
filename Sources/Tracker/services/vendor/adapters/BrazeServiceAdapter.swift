import Foundation

/**
# Links:
- https://www.braze.com/docs/developer_guide/platform_integration_guides/ios/analytics/tracking_custom_events/

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/Appboy/appboy-ios-sdk", from: "4.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Appboy_iOS_SDK", package: "appboy-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import AppboyKit
 import Tracker

 extension Appboy: BrazeServiceAdapter {
     public func setCustomAttributeWithKey(_ key: String, andStringValue value: String) {
         Appboy.sharedInstance()?.user.setCustomAttributeWithKey(key, andStringValue: value)
     }

     public func unsetCustomAttributeWithKey(_ key: String) {
         Appboy.sharedInstance()?.user.unsetCustomAttribute(withKey: key)
     }
 }
```
*/

// sourcery: AutoMockable
public protocol BrazeServiceAdapter: AnyObject {
    func changeUser(_ userId: String)
    func logCustomEvent(_ eventName: String, withProperties: [AnyHashable: Any]?)
    func setCustomAttributeWithKey(_ key: String, andStringValue value: String)
    func unsetCustomAttributeWithKey(_ key: String)
}
