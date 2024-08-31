@testable import SwiftAnalytics
import SwiftAnalyticsTracking
@testable import Tracker
import TrackerTesting
import XCTest

final class SwiftAnalyticsHandlerAdapterShould: XCTestCase {
    var serviceProvider: ServiceMock!
    var eventTracker: EventTracker!
    var sut: SwiftAnalyticsHandlerAdapter!

    override func setUp() {
        super.setUp()
        serviceProvider = ServiceMock()
        eventTracker = EventTracker(serviceProviders: [serviceProvider])
        sut = SwiftAnalyticsHandlerAdapter(eventTracker: eventTracker)
        AnalyticsSystem.bootstrapInternal(sut)
    }

    func testTrackEvents() {
        serviceProvider.underlyingTrackingDisabled = false
        let analytics = Analytics()
        analytics.send("some event")
        analytics.send("another event")

        XCTAssertEqual(serviceProvider.trackEventCallsCount, 2)
    }

    func testTrackEventsWithExpectedName() {
        serviceProvider.underlyingTrackingDisabled = false
        let analytics = Analytics()
        analytics.send("some event")

        let event = serviceProvider.trackEventReceivedEvent
        XCTAssertEqual(event?.name, "some event")
    }

    func testTrackEventsWithExpectedEventParameters() {
        serviceProvider.underlyingTrackingDisabled = false
        let analytics = Analytics()
        analytics.send("some event", parameters: ["array": .array([1, "two", .dictionary(["three": 3])])])

        let event = serviceProvider.trackEventReceivedEvent
        XCTAssertEqual(event?.parameters, ["array": "[1,\"two\",{\"three\":3}]"])
    }

    func testTrackEventsWithExpectedSharedParameters() {
        serviceProvider.underlyingTrackingDisabled = false
        var analytics = Analytics()
        analytics.parameters = ["dict": .dictionary(["array": .array([false, true])])]
        analytics.send("some event")

        let event = serviceProvider.trackEventReceivedEvent
        XCTAssertEqual(event?.parameters, ["dict": "{\"array\":[false,true]}"])
    }

    func testNotShareParametersBetweenDifferentInstances() {
        var analytics1 = Analytics()
        analytics1.parameters["only-on"] = "first"

        var analytics2 = analytics1
        analytics2.parameters["only-on"] = "second"

        XCTAssertEqual("first", analytics1.parameters["only-on"])
        XCTAssertEqual("second", analytics2.parameters["only-on"])
    }

    func testTrackEventsWithExpectedMergedParameters() {
        serviceProvider.underlyingTrackingDisabled = false
        var analytics = Analytics()
        analytics.parameters["shared"] = "some value"
        analytics.parameters["conflicting"] = "another value"
        analytics.send("some event", parameters: ["not shared": 1234, "conflicting": "different value"])

        let event = serviceProvider.trackEventReceivedEvent
        XCTAssertEqual(event?.parameters, ["not shared": "1234", "conflicting": "different value", "shared": "some value"])
    }
}
