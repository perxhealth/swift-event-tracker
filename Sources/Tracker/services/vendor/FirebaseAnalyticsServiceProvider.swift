import Foundation

public final class FirebaseAnalyticsServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.firebaseAnalytics, .analytics, .nativeEventParameters, .nativeProperties, .nativeUserId]

    private let adapter: FirebaseAnalyticsServiceAdapter.Type

    public init(adapter: FirebaseAnalyticsServiceAdapter.Type) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.logEvent(event.name, parameters: event.resolvedParameters)
    }

    public func setUserId(_ userId: String) {
        adapter.setUserID(userId)
    }

    public func resetUserId() {
        adapter.setUserID(nil)
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.setUserProperty(value, forName: key)
    }

    public func resetProperties() {
        userProperties.keys.forEach { adapter.setUserProperty(nil, forName: $0) }
        userProperties = [:]
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        adapter.setAnalyticsCollectionEnabled(!flag)
    }
}
