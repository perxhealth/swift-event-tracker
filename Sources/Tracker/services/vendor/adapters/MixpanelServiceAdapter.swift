import Foundation

/**
 # Links:
 - https://developer.mixpanel.com/docs/swift
 - https://github.com/mixpanel/mixpanel-iphone

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

 extension MixpanelInstance: MixpanelServiceAdapter {
     public func optInTracking(distinctId: String?, properties: [String: Any]?) {
         optInTracking(distinctId: distinctId, properties: dictionaryToProperties(properties))
     }

     public func set(property: String, to value: String) {
         people.set(property: property, to: value)
     }

     public func unset(properties: [String]) {
         people.unset(properties: properties)
     }

     public func track(event: String?, properties: [String: Any]?) {
         track(event: event, properties: dictionaryToProperties(properties))
     }

     private func dictionaryToProperties(_ dictionary: [String: Any]?) -> Properties? {
         guard let dictionary = dictionary else {
             return nil
         }
         return dictionaryToProperties(dictionary)
     }

     private func dictionaryToProperties(_ dictionary: [String: Any]) -> Properties {
         dictionary.reduce(into: [String: MixpanelType]()) { $0[$1.key] = $1.value as? MixpanelType }
     }
 }
 ```
 */

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
