import KochavaMeasurement
import protocol Tracker.KochavaServiceAdapter

struct KochavaAdapter: KochavaServiceAdapter {
    func sendCustomEvent(name: String, infoDictionary: [AnyHashable : Any]?) {
        Event.sendCustom(
            eventName: name,
            infoDictionary: infoDictionary
        )
    }

    func registerIdentityLink(name: String, identifier: String?) {
        IdentityLink.register(
            name: name,
            identifier: identifier
        )
    }
}
