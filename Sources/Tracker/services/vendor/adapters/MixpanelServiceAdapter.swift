import Foundation

/**
 Adapter for the Mixpanel iOS library.

 # Useful links:
 - https://developer.mixpanel.com/docs/swift

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/mixpanel/mixpanel-iphone", from: "5.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Mixpanel", package: "mixpanel-iphone"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Mixpanel
 import Tracker

 extension Mixpanel: MixpanelServiceAdapter {
     public func resetUserId() {
         identify(anonymousId)
     }

     public func set(property: String, to value: String) {
         people.set(property, to: value)
     }

     public func unset(properties: [String]) {
         people.unset(properties)
     }
 }
 ```
 */

// sourcery: AutoMockable
public protocol MixpanelServiceAdapter: AnyObject {
    func identify(_ distinctId: String)
    func resetUserId()
    func hasOptedOutTracking() -> Bool
    func optInTracking()
    func optOutTracking()
    func set(property: String, to value: String)
    func track(_ event: String, properties: [AnyHashable: Any]?)
    func unset(properties: [String])
}
