import Foundation

public final class PostHogServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.postHog, .analytics, .nativeEventParameters, .nativeProperties, .nativeScreen, .nativeUserId]

    public override var trackingDisabled: Bool { adapter.isOptOut() }

    private var adapter: PostHogServiceAdapter

    public init(adapter: PostHogServiceAdapter) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.capture(event.name, properties: event.parameters)
    }

    public func trackScreen(_ screen: Screen) {
        if let screen = screen as? PostHogScreen {
            adapter.screen(screen.name, properties: screen.properties)
        } else {
            adapter.screen(screen.name, properties: [:])
        }
    }

    public func setUserId(_ userId: String) {
        adapter.identify(userId)
    }

    public func resetUserId() {
        adapter.identify("")
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.register(userProperties)
    }

    public func resetProperties() {
        userProperties.forEach { key, _ in
            adapter.unregister(key)
        }
        userProperties = [:]
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        if flag {
            adapter.optOut()
        } else {
            adapter.optIn()
        }
    }
}
