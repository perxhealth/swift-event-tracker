import Foundation

/**
 # Links:
 - https://docs.bugsee.com/sdk/ios/custom/

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/bugsee/spm", from: "5.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "Bugsee", package: "spm"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import Bugsee
 import Tracker

 extension Bugsee: BugseeServiceAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol BugseeServiceAdapter {
    static func clearAllAttribute() -> Bool
    static func event(_ eventName: String, params: [AnyHashable: Any])
    static func pause()
    static func resume()
    static func setAttribute(_ key: String, value: Any) -> Bool
}
