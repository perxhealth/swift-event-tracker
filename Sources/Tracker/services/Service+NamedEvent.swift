import Foundation

extension Service {
    public func trackScreen(_ screen: Screen) {
        let event = NamedEvent("\(screen.name) viewed")
        trackEvent(event)
    }

    public func setUserId(_ userId: String) {
        let event =
            NamedEvent("Set user") + [
                NamedParameter(
                    key: AbstractProvider.defaultFallbackUserIdPropertyKey,
                    value: userId
                )
            ]
        trackEvent(event)
    }

    public func resetUserId() {
        let event = NamedEvent("Reset user")
        trackEvent(event)
    }

    public func setProperty(_ key: String, value: String) {
        let event =
            NamedEvent("Set property") + [
                NamedParameter(key: key, value: value)
            ]
        trackEvent(event)
    }

    public func setProperty(_ property: Parameter) {
        setProperty(property.key, value: property.value)
    }

    public func resetProperties() {
        let event = NamedEvent("Reset properties")
        trackEvent(event)
    }
}
