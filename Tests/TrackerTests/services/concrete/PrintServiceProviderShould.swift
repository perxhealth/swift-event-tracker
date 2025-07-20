@testable import Tracker
import TrackerTesting
import XCTest

final class PrintServiceProviderShould: XCTestCase {
    var sut: PrintServiceProvider!

    var someEvent: EventMock!
    var someScreen: ScreenMock!

    var someEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var somePropertyKey: String!
    var somePropertyValue: String!
    var someUserId: String!

    var receivedEventDescription: String?

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

        sut = PrintServiceProvider(canBeDisabled: false) { eventdescription in
            self.receivedEventDescription = eventdescription
        }
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testDefaultCanBeDisabledValue() {
        let sutWithDefaultCanBeDisabledValue = PrintServiceProvider() { _ in }
        XCTAssertTrue(sutWithDefaultCanBeDisabledValue.canBeDisabled)
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.debugging, .logging])
    }

    func testTrackEventWithExpectedName() throws {
        sut.trackEvent(someEvent)
        try AssertTrue(receivedEventDescription?.contains(someEventName))
    }

    func testTrackEventWithExpectedParameters() throws {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
            try AssertTrue(receivedEventDescription?.contains(key), "\"\(receivedEventDescription ?? "nil")\" does not contain \"\(key)\"")
            try AssertTrue(receivedEventDescription?.contains(value), "\"\(receivedEventDescription ?? "nil")\" does not contain \"\(value)\"")
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        try AssertTrue(receivedEventDescription?.contains(someScreenName))
    }

    func testSetPropertyUpdatesUserProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
    }

    func testTrackEventWithExpectedPropertyKey() throws {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        try AssertTrue(receivedEventDescription?.contains(somePropertyKey))
    }

    func testTrackEventWithExpectedPropertyValue() throws {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        try AssertTrue(receivedEventDescription?.contains(somePropertyValue))
    }

    func testRemovePropertiesOnResetProperties() throws {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        try AssertTrue(receivedEventDescription?.contains("Reset properties"))
    }

    func testTrackEventWithExpectedUserId() throws {
        sut.setUserId(someUserId)
        try AssertTrue(receivedEventDescription?.contains(someUserId))
    }

    func testTrackEventOnResetUserId() throws {
        sut.resetUserId()
        try AssertTrue(receivedEventDescription?.contains("Reset user"))
    }

    func testInformWhenTrackingDisabled() {
        sut.disableTracking(true)
        XCTAssertEqual(receivedEventDescription, "Disabling tracking")
    }

    func testUpdateTrackingDisabledPropertyOnlyWhenCanBeDisabled() {
        let sutWithCanBeDisabledTrue = PrintServiceProvider(canBeDisabled: true) { eventdescription in
            self.receivedEventDescription = eventdescription
        }
        sutWithCanBeDisabledTrue.disableTracking(true)
        sut.disableTracking(true)
        XCTAssertTrue(sutWithCanBeDisabledTrue.trackingDisabled)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
