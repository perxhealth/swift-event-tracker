import Foundation

public final class SegmentServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.segment, .analytics, .nativeEventParameters, .nativeProperties, .nativeScreen, .nativeUserId]

    public override var trackingDisabled: Bool { !adapter.enabled }

    private var adapter: SegmentServiceAdapter

    public init(adapter: SegmentServiceAdapter) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.track(name: event.name, properties: event.parameters)
    }

    public func trackScreen(_ screen: Screen) {
        if let screen = screen as? SegmentScreen {
            adapter.trackScreen(title: screen.name, category: screen.category, properties: screen.properties)
        } else {
            adapter.trackScreen(title: screen.name, category: nil, properties: [:])
        }
    }

    public func setUserId(_ userId: String) {
        adapter.setUserId(userId)
    }

    public func resetUserId() {
        adapter.setUserId(nil)
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.setTraits(userProperties)
    }

    public func resetProperties() {
        userProperties = [:]
        adapter.setTraits(userProperties)
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        adapter.enabled = !flag
    }
}
