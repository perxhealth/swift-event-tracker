import Mixpanel
import Tracker

extension Mixpanel: MixpanelServiceAdapter {
    public func resetUserId() {
        identify(anonymousId)
    }
        
    public func set(property: String, to value: String) {
        people.set(property, to: value)
    }

    public func unset(properties: [String]) {
        people.unset(properties)
    }
}
