import Foundation

/**
 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/amplitude/Amplitude-iOS", from: "8.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies: [.product(name: "Amplitude", package: "Amplitude-IOS"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import class Amplitude.Amplitude
 import Tracker

 extension Amplitude: AmplitudeServiceAdapter {}
 ```
 */

public protocol AmplitudeServiceAdapter: AnyObject {
    var optOut: Bool { get set }
    
    func clearUserProperties()
    func logEvent(_ eventType: String, withEventProperties: [AnyHashable: Any]?)
    func regenerateDeviceId()
    func setUserId(_ id: String?)
    func setUserProperties(_ dictionary: [AnyHashable: Any])
}
