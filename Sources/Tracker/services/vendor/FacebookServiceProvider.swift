import Foundation

public final class FacebookServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.facebook, .analytics, .nativeEventParameters, .nativeUserId]

    private var adapter: FacebookServiceAdapter
    private var settingsAdapter: FacebookSettingsAdapter

    public init(adapter: FacebookServiceAdapter, settingsAdapter: FacebookSettingsAdapter) {
        self.adapter = adapter
        self.settingsAdapter = settingsAdapter
    }

    public func trackEvent(_ event: Event) {
        adapter.logEvent(event.name, parameters: event.parameters)
    }

    public func setUserId(_ userId: String) {
        adapter.userID = userId
    }

    public func resetUserId() {
        adapter.userID = nil
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        let event = NamedEvent("Set property") + [key: value]
        trackEvent(event)
    }

    public func resetProperties() {
        let event = NamedEvent("Reset properties") + ["keys": userProperties.keys.joined(separator: ", ")]
        userProperties = [:]
        trackEvent(event)
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        settingsAdapter.isAutoLogAppEventsEnabled = flag
    }
}
