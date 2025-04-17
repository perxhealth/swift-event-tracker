# SwiftEventTracker

**SwiftEventTracker** is a simple, yet flexible, event tracking library for Swift. It enables developers to track analytics events across multiple analytics service providers using a unified, declarative API. With **SwiftEventTracker**, you can easily integrate with various analytics platforms without coupling your code to any specific SDK.

## Getting Started

### Adding the Dependency

To use **SwiftEventTracker** in your project, add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/perxhealth/swift-event-tracker", from: "2.0.1"),
```

Then, add `Tracker` to your target's dependencies:

```swift
.target(name: "YourAppTarget", dependencies: [
    .product(name: "Tracker", package: "swift-event-tracker")
]),
```

### Basic Usage

#### Importing the Library

Start by importing the `Tracker` module:

```swift
import Tracker
```

#### Setting Up Event Tracking

**1. Define Your Events and Screens:**

Create your events and screens using the `Event` and `Screen` protocols or the provided conforming structs.

```swift
let loginEvent = ParameterizedEvent(name: "login", parameters: ["method": "email"])
let homeScreen = NamedScreen(name: "HomeScreen")
```

**2. Configure Service Providers:**

Initialize the `EventTracker` with the service providers you want to use. Each service provider must conform to the `Service` protocol.

```swift
let printProvider = PrintServiceProvider()

var tracker = EventTracker(serviceProviders: [printProvider])
```

**3. Track Events and Screens:**

Use the trackEvent and trackScreen methods to track events and screen views.

```swift
tracker.trackEvent(loginEvent)
tracker.trackScreen(homeScreen)
```

### Advanced Usage

#### Conditional Tracking

##### Given Conditions

You can conditionally track events based on custom logic:

```swift
tracker.trackEvent(loginEvent, given: { user.isLoggedIn })
```

##### Tags

Conditional tracking can also be achieved by using the `Tag` structure. See **Custom Events and Screens**, **Properties and User Identifier** sections.

#### Custom Events and Screens

##### Events

You can create custom events by conforming to the `Event` protocol. This allows you to define events with specific behavior, including setting `excludedTags` and `requiredTags`, which control whether the event should be tracked based on the tags supported by the service providers.

Here’s an example:

```swift
import Tracker

struct PurchaseEvent: Event {
    let name: String = "purchase"
    let parameters: [String: String]
    let date: Date
    
    var excludedTags: [Tag] {
        return [.debugging] // Exclude this event from providers tagged with `.crashReporting`
    }
    
    var requiredTags: [Tag] {
        return [.analytics] // Only track this event with providers tagged with `.analytics`
    }
    
    init(itemID: String, price: String) {
        self.parameters = ["item_id": itemID, "price": price]
        self.date = Date()
    }
}

// Usage
let purchaseEvent = PurchaseEvent(itemID: "12345", price: "19.99")
tracker.trackEvent(purchaseEvent)
```

This event is compatible with any service provider. But only a provider with built-in support for it will handle the custom `date` property.

##### Screens

Similarly, you can define custom screens by conforming to the `Screen` protocol. This is useful for tracking screen views with custom logic, including the use of `excludedTags` and `requiredTags`.

Here’s an example:

```swift
import Tracker

struct ProductScreen: Screen {
    let name: String = "ProductScreen"
    let productID: String
    
    var excludedTags: [Tag] {
        return [.debugging] // Exclude this screen from providers tagged with `.debugging`
    }
    
    var requiredTags: [Tag] {
        return [.analytics] // Only track this screen with providers tagged with `.analytics`
    }
    
    init(productID: String) {
        self.productID = productID
    }
}

// Usage
let productScreen = ProductScreen(productID: "67890")
tracker.trackScreen(productScreen)
```

Again, only service providers with built-in support for this screen will handle the custom `productID` property.

See more examples in `[./Sources/Tracker/events/vendor/](./Sources/Tracker/events/vendor/)`.

#### Properties and User Identifier

`EventTracker` allows you to define _properties_ and a _user identifier_ that can be included in all tracked events. These attributes can be applied globally or selectively, depending on the tags associated with each service provider.

##### Setting Properties

You can set global properties that will be sent with every event:

```swift
// Global property applied to all providers
tracker.setProperty("user_type", value: "premium")

// Property applied only to providers tagged with `.crashReporting`
tracker.setProperty("app_version", value: "1.2.3", forTags: [.crashReporting])
```

##### Resetting Properties

If needed, you can reset properties either globally or for specific tags:

```swift
// Reset properties only for providers tagged with `.debugging`
tracker.resetProperties(forTags: [.debugging])

// Reset all properties for all providers
tracker.resetProperties()
```

##### Setting a User Identifier

The user identifier is another key property that can be set globally or for specific service providers:

```swift
// Global user identifier applied to all providers
tracker.setUserId("user_12345")

// User identifier applied only to providers tagged with `.analytics`
tracker.setUserId("user_12345", forTags: [.analytics])
```

##### Resetting the User Identifier

Similar to properties, the user identifier can also be reset globally or selectively:

```swift
// Reset user identifier for all providers
tracker.resetUserId()

// Reset user identifier only for providers tagged with `.logging` and `.crashReporting`
tracker.resetUserId(forTags: [.logging, .crashReporting])

```

#### Switching Service Providers at Runtime

You can dynamically update the list of service providers:

```swift
let appCenterProvider = AppCenterAnalyticsServiceProvider(adapter: Analytics.self) 
let adjustProvider = AdjustServiceProvider(adapter: Adjust.self)
let taplyticsProvider = TaplyticsServiceProvider(adapter: Taplytics.self)
let instabugProvider = InstabugServiceAdapter(adapter: Instabug.self)

tracker.setServiceProviders([appCenterProvider, adjustProvider, taplyticsProvider, instabugProvider])
```

#### Adding Custom Service Providers

**SwiftEventTracker** supports a wide range of analytics service providers, including Firebase, Amplitude, Mixpanel, and more. To add support for a new provider, you need to implement the Service protocol and provide an adapter that conforms to the corresponding adapter protocol.

Here’s a simplified example:

```swift
import Tracker

class CustomAnalyticsProvider: Service, AbstractProvider {
    let supportedTags: [Tag] = [.analytics]

    func trackEvent(_ event: Event) {
        // Implement custom event tracking logic here
    }
}
```

For further customization, you can implement the methods `trackScreen(_:)`, `setUserId(_:)`, `resetUserId()`, `setProperty(_:value:)`, `resetProperties()`, and `disableTracking(_:)`.

#### Available Service Providers

**SwiftEventTracker** ships with multiple analytics providers:

- Adjust ([provider](./Sources/Tracker/services/vendor/AdjustServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/AdjustServiceAdapter.swift))
- Amplitude ([provider](./Sources/Tracker/services/vendor/AmplitudeServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/AmplitudeServiceAdapter.swift))
- AppCenter ([provider](./Sources/Tracker/services/vendor/AppCenterAnalyticsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/AppCenterAnalyticsServiceAdapter.swift))
- AppsFlyer ([provider](./Sources/Tracker/services/vendor/AppsFlyerServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/AppsFlyerServiceAdapter.swift))
- Braze ([provider](./Sources/Tracker/services/vendor/BrazeServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/BrazeServiceAdapter.swift))
- Bugsee ([provider](./Sources/Tracker/services/vendor/BugseeServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/BugseeServiceAdapter.swift))
- Countly ([provider](./Sources/Tracker/services/vendor/CountlyServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/CountlyServiceAdapter.swift))
- Crashlytics ([provider](./Sources/Tracker/services/vendor/CrashlyticsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/CrashlyticsServiceAdapter.swift))
- Facebook ([provider](./Sources/Tracker/services/vendor/FacebookServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/FacebookServiceAdapter.swift))
- Firebase ([provider](./Sources/Tracker/services/vendor/FirebaseAnalyticsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/FirebaseAnalyticsServiceAdapter.swift))
- Heap ([provider](./Sources/Tracker/services/vendor/HeapServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/HeapServiceAdapter.swift))
- Instabug ([provider](./Sources/Tracker/services/vendor/InstabugServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/InstabugServiceAdapter.swift))
- Kochava ([provider](./Sources/Tracker/services/vendor/KochavaServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/KochavaServiceAdapter.swift))
- Localytics ([provider](./Sources/Tracker/services/vendor/LocalyticsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/LocalyticsServiceAdapter.swift))
- Mixpanel ([provider](./Sources/Tracker/services/vendor/MixpanelServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/MixpanelServiceAdapter.swift))
- PostHog ([provider](./Sources/Tracker/services/vendor/PostHogServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/PostHogServiceAdapter.swift))
- Segment ([provider](./Sources/Tracker/services/vendor/SegmentServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/SegmentServiceAdapter.swift))
- SwiftAnalytics ([provider](./Sources/Tracker/services/vendor/SwiftAnalyticsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/SwiftAnalyticsServiceAdapter.swift))
- SwiftAnalyticsKit ([provider](./Sources/Tracker/services/vendor/SwiftAnalyticsKitServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/SwiftAnalyticsKitServiceAdapter.swift))
- SwiftLogger ([provider](./Sources/Tracker/services/vendor/SwiftLoggerServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/SwiftLoggerServiceAdapter.swift))
- SwiftMetrics ([provider](./Sources/Tracker/services/vendor/SwiftMetricsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/SwiftMetricsServiceProvider.swift))
- Taplytics ([provider](./Sources/Tracker/services/vendor/TaplyticsServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/TaplyticsServiceAdapter.swift))
- UXCam ([provider](./Sources/Tracker/services/vendor/UXCamServiceProvider.swift), [adapter example](./Sources/Tracker/services/vendor/adapters/UXCamServiceAdapter.swift))

#### Implementing an Adapter

The adapter implementation for each provider is left to the consumer. Below is an example of an adapter for Firebase:

```swift
import FirebaseAnalytics
import Tracker

extension Analytics: FirebaseAnalyticsServiceAdapter {}

// Usage
let firebaseProvider = FirebaseAnalyticsServiceProvider(adapter: Analytics.self)
var tracker = EventTracker(serviceProviders: [firebaseProvider])
```

This allows **SwiftEventTracker** to leverage Firebase's capabilities without directly depending on its SDK. Be aware that your application still needs to handle Firebase configuration and initialization. 

You can find examples for the rest of supported services in the [Examples](./Examples/) package. 

## License

**SwiftEventTracker** is available under the MIT license. See the LICENSE file for more information.

## Contributing

Contributions are welcome! If you have ideas, suggestions, or would like to contribute to the codebase, feel free to open an issue or submit a pull request.

## Alternatives

- [SwiftAnalytics](https://github.com/dankinsoid/swift-analytics)
- [SwiftAnalyticsKit](https://github.com/SwiftyLab/SwiftAnalyticsKit)
