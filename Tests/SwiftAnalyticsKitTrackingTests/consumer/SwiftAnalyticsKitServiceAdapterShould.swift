@testable import Analytics
@testable import AnalyticsMock
import SwiftAnalyticsKitTracking
@testable import Tracker
import TrackerTesting
import XCTest

@available(iOS 16, *)
@available(macOS 13, *)
@available(tvOS 16, *)
@available(watchOS 9, *)
final class SwiftAnalyticsKitServiceAdapterShould: XCTestCase {
    final class MockHandler: AnalyticsHandler, Hashable {
        static func == (lhs: SwiftAnalyticsKitServiceAdapterShould.MockHandler, rhs: SwiftAnalyticsKitServiceAdapterShould.MockHandler) -> Bool {
            guard lhs.arguments.count == rhs.arguments.count else { return false }
            for i in 0 ..< lhs.arguments.count {
                guard lhs.arguments[i] == rhs.arguments[i] else { return false }
            }
            return true
        }
        
        typealias EventName = String
        typealias Argument = (eventName: String, time: Date, metadata: [String: AnyHashable])

        var arguments = [Argument]()

        func hash(into hasher: inout Hasher) {
            arguments.description.hash(into: &hasher)
        }

        func track<Event>(event: Event, at time: Date, data: Event.Metadata) where Event : Analytics.AnalyticsEvent, String == Event.Name {
            let encoder = StandardDictionaryEncoder()
            let metadata = (try! encoder.encodeMetadata(data)).mapValues { value in
                value as! AnyHashable
            }
            let argument = Argument(eventName: event.name, time: time, metadata: metadata)
            arguments.append(argument)
        }
    }

    var handler: MockHandler!
    var serviceProvider: SwiftAnalyticsKitServiceProvider!
    var eventTracker: EventTracker!
    var sut: MultiplexAnalyticsHandler<String>!

    override func setUp() {
        super.setUp()
        sut = MultiplexAnalyticsHandler<String>()
        handler = MockHandler()
        sut.register(handler: handler, for: .defaultGroups)
        serviceProvider = SwiftAnalyticsKitServiceProvider(adapter: sut)
        eventTracker = EventTracker(serviceProviders: [serviceProvider])
    }

    func testTrackEventWithNameAndParameters() {
        let event = ParameterizedEvent(name: "Test Event", parameters: ["param1": "value1", "param2": "value2"])
        eventTracker.trackEvent(event)

        XCTAssertEqual(handler.arguments.last?.eventName, "Test Event")
        XCTAssertEqual(handler.arguments.last?.eventName, "Test Event")
        XCTAssertEqual(handler.arguments.last?.metadata, ["data": ["param1": "value1", "param2": "value2"]])
    }

    func testTrackEventWithProperties() {
        eventTracker.setProperty("param1", value: "value1")
        eventTracker.setProperty("param2", value: "value2")
        let event = ParameterizedEvent(name: "Test Event", parameters: ["param3": "value3"])
        eventTracker.trackEvent(event)

        XCTAssertEqual(handler.arguments.last?.eventName, "Test Event")
        XCTAssertEqual(handler.arguments.first?.metadata, ["data": ["param1": "value1"]])
        XCTAssertEqual(handler.arguments[1].metadata, ["data": ["param2": "value2"]])
        XCTAssertEqual(handler.arguments.last?.metadata, ["data": ["param3": "value3"]])
    }

    func testResetProperties() {
        eventTracker.setProperty("param1", value: "value1")
        eventTracker.resetProperties()
        let event = ParameterizedEvent(name: "Test Event", parameters: ["param2": "value2"])
        eventTracker.trackEvent(event)

        XCTAssertEqual(handler.arguments.last?.eventName, "Test Event")
        XCTAssertEqual(handler.arguments[1].metadata, ["data": ["keys": "param1"]])
        XCTAssertEqual(handler.arguments.last?.metadata, ["data": ["param2": "value2"]])
    }
}
