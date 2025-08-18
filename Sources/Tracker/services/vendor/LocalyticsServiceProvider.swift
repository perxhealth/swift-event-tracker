import Foundation

public final class LocalyticsServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.localytics, .analytics, .nativeEventParameters, .nativeProperties, .nativeScreen, .nativeUserId]

    public override var trackingDisabled: Bool { adapter.isPrivacyOptedOut() || adapter.isOptedOut() }

    private var adapter: LocalyticsServiceAdapter.Type

    public init(adapter: LocalyticsServiceAdapter.Type) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.tagEvent(event.name, attributes: event.resolvedParameters)
    }

    public func trackScreen(_ screen: Screen) {
        adapter.tagScreen(screen.name)
    }

    public func setUserId(_ userId: String) {
        adapter.setCustomerId(userId)
    }

    public func resetUserId() {
        adapter.setCustomerId(nil)
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.setValue(value, forIdentifier: key)
    }

    public func resetProperties() {
        userProperties.forEach { key, _ in
            adapter.setValue(nil, forIdentifier: key)
        }
        userProperties = [:]
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        adapter.setOptedOut(flag)
        adapter.setPrivacyOptedOut(flag)
    }
}
