import Foundation

extension Service where Self: AbstractProvider {
    public func setUserId(_ userId: String) {
        if let key = userIdPropertyKey {
            setProperty(key, value: userId)
        } else {
            let event = ParameterizedEvent(name: "Set user identifier", parameters: ["id": userId])
            trackEvent(event)
        }
    }

    public func resetUserId() {
        if let key = userIdPropertyKey {
            setProperty(key, value: "")
            userProperties[key] = nil
        } else {
            let event = NamedEvent("Reset user identifier")
            trackEvent(event)
        }
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        let event = ParameterizedEvent(name: "Set property", parameters: [key: value])
        trackEvent(event)
    }

    public func resetProperties() {
        let event = ParameterizedEvent(name: "Reset properties", parameters: ["keys": userProperties.keys.joined(separator: ", ")])
        if let userIdKey = userIdPropertyKey, let userId = userProperties[userIdKey] {
            userProperties = [userIdKey: userId]
        } else {
            userProperties = [:]
        }
        trackEvent(event)
    }
}
