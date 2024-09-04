import class Segment.Analytics
import struct Segment.IdentifyEvent
import struct Segment.ScreenEvent
import enum Segment.JSON
import protocol Tracker.SegmentServiceAdapter
import protocol Tracker.SegmentScreen

extension Analytics: SegmentServiceAdapter {
    public func setTraits(_ traits: [String: Any]) {
        let json = jsonFromDictionary(traits)
        let event = IdentifyEvent(userId: userId, traits: json)
        process(event: event)
    }

    public func setUserId(_ userId: String?) {
        let traits: JSON? = traits()
        let event = IdentifyEvent(userId: userId, traits: traits)
        process(event: event)
    }

    public func track(name: String, properties: [String : Any]) {
        let json = jsonFromDictionary(properties)
        track(name: name, properties: json)
    }

    public func trackScreen(title: String, category: String?, properties: [String: Any]) {
        let json = jsonFromDictionary(properties)
        let event = ScreenEvent(title: title, category: category, properties: json)
        process(event: event)
    }

    private func jsonFromDictionary(_ dictionary: [String: Any]) -> JSON? {
        do {
            return try JSON(nilOrObject: dictionary)
        } catch {
            assertionFailure("ERROR: \(error)")
            return nil
        }

    }
}
