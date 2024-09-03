@testable import Tracker
@testable import TrackerTesting
import XCTest

final class AppsFlyerServiceProviderShould: XCTestCase {
    var sut: AppsFlyerServiceProvider!
    var adapter: AppsFlyerServiceAdapterMock!

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

        adapter = AppsFlyerServiceAdapterMock()
        sut = AppsFlyerServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.appsFlyer, .analytics])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventEventNameStringWithValuesAnyHashableAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedArguments?.withValues?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logEventEventNameStringWithValuesAnyHashableAnyVoidCalled)
        try AssertTrue(adapter.logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        for (key, value) in adapter.customData ?? [:] {
            XCTAssertEqual(key.base as? String, somePropertyKey)
            XCTAssertEqual(value as? String, somePropertyValue)
        }
    }

    func testRemovePropertiesOnResetProperties() throws {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        try AssertTrue(adapter.customData?.isEmpty)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.customerUserID, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertNil(adapter.customerUserID)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertTrue(adapter.isStopped)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(adapter.isStopped)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
