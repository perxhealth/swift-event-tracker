import SwiftAnalyticsTracking
import TrackerTesting
import XCTest

@testable import SwiftAnalytics
@testable import Tracker

final class SwiftAnalyticsServiceAdapterShould: XCTestCase {
    var serviceProvider: SwiftAnalyticsServiceProvider!
    var eventTracker: EventTracker!
    var handler: MockAnalyticsHandler!
    var sut: Analytics!

    override func setUp() {
        super.setUp()
        handler = MockAnalyticsHandler()
        AnalyticsSystem.bootstrapInternal(handler)
        sut = Analytics()
        serviceProvider = SwiftAnalyticsServiceProvider(adapter: sut)
        eventTracker = EventTracker(serviceProviders: [serviceProvider])
    }

    func testTrackEventWithNameAndParameters() {
        let event = ParameterizedEvent(
            name: "Test Event",
            parameters: [
                NamedParameter(key: "param1", value: "value1"),
                NamedParameter(key: "param2", value: "value2"),
            ]
        )
        eventTracker.trackEvent(event)

        XCTAssertEqual(handler.events.last?.name, "Test Event")
        XCTAssertEqual(
            handler.events.last?.parameters,
            ["param1": "value1", "param2": "value2"]
        )
    }

    func testTrackEventWithProperties() {
        eventTracker.setProperty("param1", value: "value1")
        eventTracker.setProperty("param2", value: "value2")
        let event = ParameterizedEvent(
            name: "Test Event",
            parameters: [NamedParameter(key: "param3", value: "value3")]
        )
        eventTracker.trackEvent(event)

        XCTAssertEqual(handler.events.last?.name, "Test Event")
        XCTAssertEqual(
            handler.parameters,
            ["param1": "value1", "param2": "value2"]
        )
        XCTAssertEqual(handler.events.last?.parameters, ["param3": "value3"])
    }

    func testResetProperties() {
        eventTracker.setProperty("param1", value: "value1")
        eventTracker.resetProperties()
        let event = ParameterizedEvent(
            name: "Test Event",
            parameters: [NamedParameter(key: "param2", value: "value2")]
        )
        eventTracker.trackEvent(event)

        XCTAssertEqual(handler.events.last?.name, "Test Event")
        XCTAssertEqual(handler.parameters, [:])
        XCTAssertEqual(handler.events.last?.parameters, ["param2": "value2"])
    }
}
