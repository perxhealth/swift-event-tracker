import Foundation

extension Service where Self: AbstractProvider {
    public func setUserId(_ userId: String) {
        if let key = userIdPropertyKey {
            setProperty(key, value: userId)
        } else {
            let event = ParameterizedEvent(
                name: "Set user identifier",
                parameters: [
                    NamedParameter(
                        key: "id",
                        value: userId
                    )
                ]
            )
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
        let event = ParameterizedEvent(
            name: "Set property",
            parameters: [NamedParameter(key: key, value: value)]
        )
        trackEvent(event)
    }

    public func setProperty(_ parameter: any Parameter) {
        setProperty(parameter.key, value: parameter.value)
    }

    public func resetProperties() {
        let event = ParameterizedEvent(
            name: "Reset properties",
            parameters: [
                NamedParameter(
                    key: "keys",
                    value: userProperties.map { $0.key }.joined(separator: ", ")
                )
            ]
        )
        if let userIdKey = userIdPropertyKey,
            let userId = userProperties.first(where: { $0.key == userIdKey })?
                .value
        {
            userProperties = [userIdKey: userId]
        } else {
            userProperties = [:]
        }
        trackEvent(event)
    }
}
