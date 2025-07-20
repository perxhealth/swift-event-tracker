import TrackerTesting
import XCTest

@testable import Tracker

final class AbstractProviderServiceShould: XCTestCase {
    final class AbstractProviderService: AbstractProvider, Service {
        var supportedTags = [Tracker.Tag]()

        // MARK: trackEvent

        var trackEventEventEventVoidCallsCount = 0
        var trackEventEventEventVoidCalled: Bool {
            return trackEventEventEventVoidCallsCount > 0
        }
        var trackEventEventEventVoidReceivedEvent: Event?
        var trackEventEventEventVoidReceivedInvocations: [Event] = []
        var trackEventClosure: ((Event) -> Void)?

        override init(userIdPropertyKey: String? = nil) {
            super.init(userIdPropertyKey: userIdPropertyKey)
        }

        func trackEvent(_ event: Event) {
            trackEventEventEventVoidCallsCount += 1
            trackEventEventEventVoidReceivedEvent = event
            trackEventEventEventVoidReceivedInvocations.append(event)
            trackEventClosure?(event)
        }
    }

    var sut: AbstractProviderService!

    var someEvent: EventMock!
    var someScreen: ScreenMock!

    var someEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var somePropertyKey: String!
    var somePropertyValue: String!
    var someUserId: String!

    override func setUp() {
        super.setUp()
        someEventName = "some event name"
        parameters = ["param0": "value0", "param1": "value1"]
        someScreenName = "some screen name"
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        someScreen = ScreenMock(name: someScreenName)
    }

    func testStartEnabled() throws {
        let sut = AbstractProviderService()

        try AssertFalse(sut.trackingDisabled)
    }

    func testAssignFallbackUserIdPropertyKey() {
        let sut = AbstractProviderService(
            userIdPropertyKey: "user id property key"
        )

        XCTAssertEqual(sut.userIdPropertyKey, "user id property key")
    }

    func testTrackEventWithExpectedScreenName() throws {
        let sut = AbstractProviderService()
        sut.trackScreen(someScreen)
        try AssertTrue(
            sut.trackEventEventEventVoidReceivedEvent?.name.contains(
                someScreenName
            )
        )
    }

    func testTrackEventWithExpectedProperty() {
        let sut = AbstractProviderService()
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(
            sut.trackEventEventEventVoidReceivedEvent?.resolvedParameters[
                somePropertyKey
            ],
            somePropertyValue
        )
        XCTAssertEqual(sut.userProperties.count, 1)
    }

    func testRemovePropertiesOnResetProperties() throws {
        let sut = AbstractProviderService()
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        try AssertTrue(
            sut.trackEventEventEventVoidReceivedEvent?.name.contains(
                "Reset properties"
            )
        )
        XCTAssertEqual(sut.userProperties.count, 0)
    }

    func testDoNotRemoveUserPropertyOnResetProperties() throws {
        let sut = AbstractProviderService(userIdPropertyKey: "some user id key")
        sut.setUserId("some user id value")
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertEqual(
            sut.userProperties["some user id key"] as? String,
            "some user id value"
        )
    }

    func testSetPropertyWithExpectedUserId() throws {
        let sut = AbstractProviderService(
            userIdPropertyKey: "user id property key"
        )
        sut.setUserId(someUserId)
        try AssertFalse(
            sut.trackEventEventEventVoidReceivedEvent?.name.contains(someUserId)
        )
        XCTAssertEqual(
            sut.userProperties["user id property key"] as? String,
            someUserId
        )
    }

    func testUnsetPropertyOnResetUserId() throws {
        let sut = AbstractProviderService(
            userIdPropertyKey: "user id property key"
        )
        sut.resetUserId()
        try AssertFalse(
            sut.trackEventEventEventVoidReceivedEvent?.name.contains(
                "Reset user"
            )
        )
        XCTAssertNil(sut.userProperties["user id property key"])
    }

    func testTrackEventWithExpectedUserId() {
        let sut = AbstractProviderService()
        sut.setUserId(someUserId)
        XCTAssertEqual(
            sut.trackEventEventEventVoidReceivedEvent?.name,
            "Set user identifier"
        )
        XCTAssertEqual(
            sut.trackEventEventEventVoidReceivedEvent?.resolvedParameters,
            ["id": someUserId]
        )
    }

    func testTrackEventOnResetUserId() throws {
        let sut = AbstractProviderService()
        sut.resetUserId()
        try AssertTrue(
            sut.trackEventEventEventVoidReceivedEvent?.name.contains(
                "Reset user"
            )
        )
    }

    func testDisableTracking() throws {
        let sut = AbstractProviderService()
        sut.disableTracking(true)

        try AssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() throws {
        let sut = AbstractProviderService()
        sut.disableTracking(false)

        try AssertFalse(sut.trackingDisabled)
    }
}
