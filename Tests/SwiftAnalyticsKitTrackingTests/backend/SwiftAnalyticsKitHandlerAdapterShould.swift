@testable import Analytics
import SwiftAnalyticsKitTracking
@testable import Tracker
import TrackerTesting
import XCTest

@available(iOS 16, *)
@available(macOS 13, *)
@available(tvOS 16, *)
@available(watchOS 9, *)
final class SwiftAnalyticsKitHandlerAdapterShould: XCTestCase {
    struct SomeMetadata: AnalyticsMetadata {
        let someString: String?
        let someInteger: Int?

        init(someString: String? = nil, someInteger: Int? = nil) {
            self.someString = someString
            self.someInteger = someInteger
        }
    }
    
    var serviceProvider: ServiceMock!
    var eventTracker: EventTracker!
    var sut: SwiftAnalyticsKitHandlerAdapter!
    var analytics: MultiplexAnalyticsHandler<String>!

    override func setUp() {
        super.setUp()
        serviceProvider = ServiceMock()
        eventTracker = EventTracker(serviceProviders: [serviceProvider])
        sut = SwiftAnalyticsKitHandlerAdapter(eventTracker: eventTracker)
        analytics = MultiplexAnalyticsHandler()
        analytics.register(handler: sut, for: .defaultGroups)
    }

    func testTrackEvents() {
        serviceProvider.underlyingTrackingDisabled = false
        SomeAnalyticsEvent<String, SomeMetadata>(name: "some event").fire(on: analytics, data: SomeMetadata())
        SomeAnalyticsEvent<String, SomeMetadata>(name: "another event").fire(on: analytics, data: SomeMetadata())

        XCTAssertEqual(serviceProvider.trackEventEventEventVoidCallsCount, 2)
    }

    func testTrackEventsWithExpectedName() {
        serviceProvider.underlyingTrackingDisabled = false
        SomeAnalyticsEvent<String, SomeMetadata>(name: "some event")
            .fire(on: analytics, data: SomeMetadata())

        let event = serviceProvider.trackEventEventEventVoidReceivedEvent
        XCTAssertEqual(event?.name, "some event")
    }

    func testTrackEventsWithExpectedEventParameters() {
        serviceProvider.underlyingTrackingDisabled = false
        SomeAnalyticsEvent<String, SomeMetadata>(name: "some event")
            .fire(on: analytics, data: SomeMetadata(someString: "some string", someInteger: 15))

        let event = serviceProvider.trackEventEventEventVoidReceivedEvent
        XCTAssertEqual(event?.resolvedParameters, ["someString": "some string", "someInteger": "15"])
    }
}
