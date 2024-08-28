import class AdjustSdk.Adjust
import class AdjustSdk.ADJEvent
import Tracker

extension Adjust: AdjustServiceAdapter {
    public static func trackEvent(_ eventName: String, parameters: [String: String]) {
        guard let event = ADJEvent(eventToken: eventName) else {
            return
        }
        event.setValuesForKeys(parameters)
        Adjust.trackEvent(event)
    }

    public static func setEnabled(_ flag: Bool) {
        if flag {
            Adjust.enable()
        } else {
            Adjust.disable()
        }
    }
}
