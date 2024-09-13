@testable import Tracker
import TrackerTesting
import XCTest

final class SwiftLoggerServiceProviderShould: XCTestCase {
    var sut: SwiftLoggerServiceProvider!
    var adapter: SwiftLoggerServiceAdapterMock!

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

        adapter = SwiftLoggerServiceAdapterMock()
        sut = SwiftLoggerServiceProvider(adapter: adapter)
        adapter.logMessageStringVoidClosure = { eventdescription in
            self.receivedEventDescription = eventdescription
        }
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.swiftLogger, .logging])
    }

    func testTrackEventWithExpectedName() throws {
        sut.trackEvent(someEvent)
        try AssertTrue(receivedEventDescription?.contains(someEventName))
    }

    func testTrackEventWithExpectedParameters() throws {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
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

    func testResetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertNil(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey])
    }

    func testResetUserIdTracksEventWithExpectedEventName() throws {
        sut.setUserId(someUserId)
        sut.resetUserId()
        try AssertTrue(receivedEventDescription?.contains("Set property"))
    }

    func testDisableTrackingTracksEventWithExpectedEventName() {
        sut.disableTracking(true)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
