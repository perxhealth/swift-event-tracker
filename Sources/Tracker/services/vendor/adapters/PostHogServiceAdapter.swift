import Foundation

/**
 Adapter for the PostHog iOS SDK.

 # Useful links:
 - https://posthog.com/docs/libraries/ios

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     platforms: [.iOS(.v13)],
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/PostHog/posthog-ios", from: "3.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "PostHog", package: "posthog-ios"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import PostHog
 import Tracker

 extension PostHogSDK: PostHogServiceAdapter {}
 ```
 */
// sourcery: AutoMockable
public protocol PostHogServiceAdapter {
    func register(_ properties: [String: Any])
    func unregister(_ key: String)
    func identify(_ distinctId: String)
    func reset()
    func capture(_ event: String, properties: [String: Any]?)
    func screen(_ screenTitle: String, properties: [String: Any]?)
    func optIn()
    func optOut()
    func isOptOut() -> Bool
}
