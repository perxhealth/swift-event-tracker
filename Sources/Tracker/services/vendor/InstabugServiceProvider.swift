import Foundation

public final class InstabugServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.instabug, .crashReporting, .nativeProperties]

    private let adapter: InstabugServiceAdapter.Type

    public init(adapter: InstabugServiceAdapter.Type) {
        self.adapter = adapter
        super.init(userIdPropertyKey: Self.defaultFallbackUserIdPropertyKey)
    }

    public func trackEvent(_ event: Event) {
        adapter.logUserEvent(withName: event.name)
        for (key, value) in event.parameters {
            adapter.setUserAttribute(value, withKey: event.name + " -> " + key)
        }
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.setUserAttribute(value, withKey: key)
    }

    public func resetProperties() {
        userProperties.keys.forEach { adapter.removeUserAttribute(forKey: $0) }
        userProperties = [:]
    }
}
