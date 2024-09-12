import Foundation

public final class KochavaServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.kochava, .analytics, .nativeEventParameters, .nativeUserId]

    private var adapter: KochavaServiceAdapter
    private let identityLinkName: String

    public init(adapter: KochavaServiceAdapter, identityLinkName: String = KochavaServiceProvider.defaultFallbackUserIdPropertyKey) {
        self.adapter = adapter
        self.identityLinkName = identityLinkName
    }

    public func trackEvent(_ event: Event) {
        adapter.sendCustomEvent(name: event.name, infoDictionary: event.parameters)
    }

    public func setUserId(_ userId: String) {
        adapter.registerIdentityLink(name: identityLinkName, identifier: userId)
    }

    public func resetUserId() {
        adapter.registerIdentityLink(name: identityLinkName, identifier: nil)
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
}
