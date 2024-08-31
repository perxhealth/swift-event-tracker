// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Examples",
    dependencies: [
        .package(name: "Tracker", path: "../"),
        .package(url: "https://github.com/adjust/ios_sdk", from: "5.0.0"),
        .package(url: "https://github.com/amplitude/Amplitude-iOS", from: "8.0.0"),
        .package(url: "https://github.com/microsoft/appcenter-sdk-apple", from: "5.0.0"),
        .package(url: "https://github.com/AppsFlyerSDK/AppsFlyerFramework", from: "6.0.0"),
        .package(url: "https://github.com/Appboy/appboy-ios-sdk", from: "4.0.0"),
        .package(url: "https://github.com/bugsee/spm", from: "5.0.0"),
        .package(url: "https://github.com/Countly/countly-sdk-ios", from: "24.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.0.0"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk", from: "17.0.0"),
        .package(url: "https://github.com/Instabug/Instabug-SP", from: "13.0.0"),
        .package(url: "https://github.com/mixpanel/mixpanel-iphone", from: "5.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/taplytics/taplytics-ios-sdk", from: "4.0.0"),
        .package(url: "https://github.com/uxcam/uxcam-ios-sdk", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "AdjustAdapter",
            dependencies: [.product(name: "AdjustSdk", package: "ios_sdk"), "Tracker"]
        ),
        .target(
            name: "AmplitudeAdapter",
            dependencies: [.product(name: "Amplitude", package: "Amplitude-IOS"), "Tracker"]
        ),
        .target(
            name: "AppCenterAdapter",
            dependencies: [.product(name: "AppCenterAnalytics", package: "appcenter-sdk-apple"), "Tracker"]
        ),
        .target(
            name: "AppsFlyerAdapter",
            dependencies: [.product(name: "AppsFlyerLib", package: "AppsFlyerFramework"), "Tracker"]
        ),
        .target(
            name: "BrazeAdapter",
            dependencies:  [.product(name: "AppboyKit", package: "appboy-ios-sdk"), "Tracker"]
        ),
        .target(
            name: "BugseeAdapter",
            dependencies:  [.product(name: "Bugsee", package: "spm"), "Tracker"]
        ),
        .target(
            name: "CountlyAdapter",
            dependencies:  [.product(name: "Countly", package: "countly-sdk-ios"), "Tracker"]
        ),
        .target(
            name: "CrashlyticsAdapter",
            dependencies:  [.product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"), "Tracker"]
        ),
        .target(
            name: "FacebookAdapter",
            dependencies:  [.product(name: "FacebookCore", package: "facebook-ios-sdk"), "Tracker"]
        ),
        .target(
            name: "FirebaseAnalyticsAdapter",
            dependencies:  [.product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"), "Tracker"]
        ),
        .target(
            name: "InstabugAdapter",
            dependencies:  [.product(name: "Instabug", package: "Instabug-SP"), "Tracker"]
        ),
        .target(
            name: "MixpanelAdapter",
            dependencies:  [.product(name: "Mixpanel", package: "mixpanel-iphone"), "Tracker"]
        ),
        .target(
            name: "SwiftLogger",
            dependencies: [.product(name: "Logging", package: "swift-log"), "Tracker"]
        ),
        .target(
            name: "TaplyticsAdapter",
            dependencies:  [.product(name: "Taplytics", package: "taplytics-ios-sdk"), "Tracker"]
        ),
        .target(
            name: "UXCamAdapter",
            dependencies:  [.product(name: "UXCam", package: "uxcam-ios-sdk"), "Tracker"]
        ),
    ]
)
