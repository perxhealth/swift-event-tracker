import Foundation

public final class BugseeServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.bugsee, .crashReporting, .nativeEventParameters, .nativeProperties]

    private let adapter: BugseeServiceAdapter.Type

    public init(adapter: BugseeServiceAdapter.Type) {
        self.adapter = adapter
        super.init(userIdPropertyKey: Self.defaultFallbackUserIdPropertyKey)
    }

    public func trackEvent(_ event: Event) {
        adapter.event(event.name, params: event.parameters)
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        _ = adapter.setAttribute(key, value: value)
    }

    public func resetProperties() {
        userProperties = [:]
        _ = adapter.clearAllAttribute()
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        if flag {
            adapter.pause()
        } else {
            adapter.resume()
        }
    }
}
