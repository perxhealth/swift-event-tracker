import Foundation

public final class HeapServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.heap, .analytics, .nativeEventParameters, .nativeProperties, .nativeUserId]

    public override var trackingDisabled: Bool { !adapter.isTrackingEnabled() }

    private let adapter: HeapServiceAdapter.Type

    public init(adapter: HeapServiceAdapter.Type) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.track(event.name, withProperties: event.resolvedParameters)
    }

    public func setUserId(_ userId: String) {
        adapter.identify(userId)
    }

    public func resetUserId() {
        adapter.resetIdentity()
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.addUserProperties(userProperties)
    }

    public func resetProperties() {
        userProperties = [:]
        adapter.addUserProperties(userProperties)
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        adapter.setTrackingEnabled(!flag)
    }
}
