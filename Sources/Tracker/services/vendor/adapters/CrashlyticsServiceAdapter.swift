import Foundation

/**
 # Links:
 - https://firebase.google.com/docs/crashlytics/upgrade-sdk
 
 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies:  [.product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import FirebaseCrashlytics
 import Tracker

 extension Crashlytics: CrashlyticsServiceAdapter {}
 ```
 */

// sourcery: AutoMockable
public protocol CrashlyticsServiceAdapter: AnyObject {
    func deleteUnsentReports()
    func log(_ msg: String)
    func record(error: Swift.Error)
    func setCrashlyticsCollectionEnabled(_ flag: Bool)
    func isCrashlyticsCollectionEnabled() -> Bool
    func setCustomValue(_ value: Any?, forKey: String)
    func setUserID(_ userId: String?)
}
