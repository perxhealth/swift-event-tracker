import Foundation

/**
# Links:
- https://support.appsflyer.com/hc/en-us/articles/207032066-iOS-SDK-integration-for-developers#core-apis

 # Package example:
 ```
 // swift-tools-version: 5.10

 import PackageDescription

 let package = Package(
     name: "Example",
     dependencies: [
         .package(name: "Tracker", path: "./swift-event-tracker"),
         .package(url: "https://github.com/AppsFlyerSDK/AppsFlyerFramework", from: "6.0.0"),
     ],
     targets: [
         .target(name: "Example", dependencies: [.product(name: "AppsFlyerLib", package: "AppsFlyerFramework"), "Tracker"]),
     ]
 )
 ```

 # Integration example:
 ```
 import AppsFlyerLib
 import Tracker

 extension AppsFlyerLib: AppsFlyerServiceAdapter {}
 ```
*/

public protocol AppsFlyerServiceAdapter: AnyObject {
    var customData: [AnyHashable: Any]? { get set }
    var customerUserID: String? { get set }
    var isStopped: Bool { get set }

    func logEvent(_ eventName: String, withValues: [AnyHashable: Any]?)
}
