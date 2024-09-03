import Foundation

/**
 # Links:
 - https://developers.facebook.com/docs/app-events/getting-started-app-events-ios
 - https://developers.facebook.com/docs/analytics/quickstart-list/ios/

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/facebook/facebook-ios-sdk", from: "17.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "FacebookCore", package: "facebook-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import FacebookCore
 import Tracker

 extension AppEvents: FacebookServiceAdapter {
     public func clearUserID() {
         self.userID = nil
     }

     public func logEvent(_ eventName: String, parameters: [String: Any]) {
         var namedParameters = [AppEvents.ParameterName: Any]()
         for (key, value) in parameters {
             namedParameters[AppEvents.ParameterName(rawValue: key)] = value
         }
         logEvent(AppEvents.Name(rawValue: eventName), parameters: namedParameters)
     }
 }

 extension Settings: FacebookSettingsAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol FacebookServiceAdapter {
    var userID: String? { get set }

    func clearUserID()
    func logEvent(_ eventName: String, parameters: [String : Any])
}

// sourcery: AutoMockable
public protocol FacebookSettingsAdapter {
    var isAutoLogAppEventsEnabled: Bool { get set }
}
