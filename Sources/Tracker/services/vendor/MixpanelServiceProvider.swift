import Foundation

public final class MixpanelServiceProvider: AbstractProvider, Service {
    public let supportedTags: [Tag] = [.mixpanel, .analytics]

    public override var trackingDisabled: Bool { adapter.hasOptedOutTracking() }

    private let adapter: MixpanelServiceAdapter

    public init(adapter: MixpanelServiceAdapter) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.track(event.name, properties: event.parameters)
    }

    public func setUserId(_ userId: String) {
        adapter.identify(userId)
    }

    public func resetUserId() {
        adapter.resetUserId()
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.set(property: key, to: value)
    }

    public func resetProperties() {
        adapter.unset(properties: Array(userProperties.keys))
        userProperties = [:]
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        if flag {
            adapter.optOutTracking()
        } else {
            adapter.optInTracking()
        }
    }
}
