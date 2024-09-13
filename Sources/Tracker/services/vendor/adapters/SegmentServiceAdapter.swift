import Foundation

/**
 Adapter for the Segment analytics library.

 # Useful links:
 - https://segment.com/docs/connections/sources/catalog/libraries/mobile/apple/

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     platforms: [.iOS(.v13)],
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/segmentio/analytics-swift", from: "1.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Segment", package: "analytics-swift"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Segment
 import Tracker

 extension Analytics: SegmentServiceAdapter {
     public func setTraits(_ traits: [String: Any]) {
         let json = jsonFromDictionary(traits)
         let event = IdentifyEvent(userId: userId, traits: json)
         process(event: event)
     }

     public func setUserId(_ userId: String?) {
         let traits: JSON? = traits()
         let event = IdentifyEvent(userId: userId, traits: traits)
         process(event: event)
     }

     public func trackScreen(title: String, category: String?, properties: [String: Any]) {
         let json = jsonFromDictionary(properties)
         let event = ScreenEvent(title: title, category: category, properties: json)
         process(event: event)
     }

     private func jsonFromDictionary(_ dictionary: [String: Any]) -> JSON? {
         do {
             return try JSON(nilOrObject: dictionary)
         } catch {
             assertionFailure("ERROR: \(error)")
             return nil
         }

     }
 }
 ```
 */
// sourcery: AutoMockable
public protocol SegmentServiceAdapter {
    var enabled: Bool { get set }

    func setTraits(_ traits: [String: Any])
    func setUserId(_ userId: String?)
    func track(name: String, properties: [String: Any])
    func trackScreen(title: String, category: String?, properties: [String: Any])
}
