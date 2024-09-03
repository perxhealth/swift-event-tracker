@testable import Tracker
@testable import TrackerTesting
import XCTest

final class BrazeServiceProviderShould: XCTestCase {
    var sut: BrazeServiceProvider!
    var adapter: BrazeServiceAdapterMock!

    var someEvent: EventMock!
    var anotherEvent: EventMock!
    var someScreen: ScreenMock!
    var anotherScreen: ScreenMock!

    var someEventName: String!
    var anotherEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var anotherScreenName: String!
    var somePropertyKey: String!
    var somePropertyValue: String!
    var someUserId: String!

    var receivedEventDescription: String?

    override func setUp() {
        super.setUp()
        someEventName = "some event name"
        anotherEventName = "another event name"
        parameters = ["param0": "value0", "param1": "value1"]
        someScreenName = "some screen name"
        anotherScreenName = "another screen name"
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        anotherEvent = EventMock(name: anotherEventName)
        someScreen = ScreenMock()
        someScreen.name = someScreenName
        anotherScreen = ScreenMock(name: anotherScreenName)

        adapter = BrazeServiceAdapterMock()
        sut = BrazeServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.braze, .analytics])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidCalled)
        XCTAssertEqual(adapter.logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedArguments?.withProperties?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidCalled)
        try AssertTrue(adapter.logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertTrue(adapter.setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidCalled)
        XCTAssertEqual(adapter.setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidReceivedArguments?.key, somePropertyKey)
        XCTAssertEqual(adapter.setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidReceivedArguments?.value, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.unsetCustomAttributeWithKeyKeyStringVoidCalled)
        XCTAssertEqual(adapter.unsetCustomAttributeWithKeyKeyStringVoidReceivedKey, somePropertyKey)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.changeUserUserIdStringVoidCalled)
        XCTAssertEqual(adapter.changeUserUserIdStringVoidReceivedUserId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.changeUserUserIdStringVoidCalled)
        XCTAssertEqual(adapter.changeUserUserIdStringVoidReceivedUserId, "")
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
