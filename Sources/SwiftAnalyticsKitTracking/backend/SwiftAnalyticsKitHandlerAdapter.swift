import Foundation
import Analytics
import Tracker

/**
 [SwiftAnalyticsKit](https://github.com/SwiftyLab/SwiftAnalyticsKit) backend.
 */
public struct SwiftAnalyticsKitHandlerAdapter: AnalyticsHandler, Hashable {
    public typealias EventName = String

    public static func == (lhs: SwiftAnalyticsKitHandlerAdapter, rhs: SwiftAnalyticsKitHandlerAdapter) -> Bool {
        lhs.eventTracker === rhs.eventTracker
    }

    private let eventTracker: EventTracker

    public init(eventTracker: EventTracker) {
        self.eventTracker = eventTracker
    }

    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(eventTracker).hash(into: &hasher)
    }

    /// Send an event to the backend.
    public func track<Event>(event: Event, at time: Date, data: Event.Metadata) where Event : AnalyticsEvent, String == Event.Name {
        let jsonData = try? JSONEncoder().encode(data)
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData ?? Data(), options: .allowFragments) as? [String: Any]
        let parameters = dictionary?.reduce([]) { partialResult, value in
            return partialResult + [NamedParameter(key: value.key, value: String(describing: value.value))]
        }
        let parameterizedEvent = ParameterizedEvent(name: event.name, parameters: parameters ?? [])
        eventTracker.trackEvent(parameterizedEvent)
    }
}
