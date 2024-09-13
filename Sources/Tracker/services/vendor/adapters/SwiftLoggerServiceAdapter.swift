import Foundation

/**
 Adapter for the SwiftLog API package.

 # Useful links:
 - https://apple.github.io/swift-log/docs/current/Logging/Structs/Logger.html

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/apple/swift-log", from: "1.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies: [.product(name: "Logging", package: "swift-log"),
     ]
 )
 ```

 # Integration example:
 ```
 import Logging
 import Tracker

 extension Logger: SwiftLoggerServiceAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol SwiftLoggerServiceAdapter {
    func log(_ message: String)
}
