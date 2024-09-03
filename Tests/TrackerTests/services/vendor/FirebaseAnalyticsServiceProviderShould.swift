@testable import Tracker
import TrackerTesting
import XCTest

final class FirebaseAnalyticsServiceProviderShould: XCTestCase {
    var sut: FirebaseAnalyticsServiceProvider!
    var adapter: FirebaseAnalyticsServiceAdapterMock.Type!

    var someEvent: EventMock!
    var anotherEvent: EventMock!
    var someScreen: FirebaseAnalyticsScreenMock!
    var anotherScreen: ScreenMock!

    var someEventName: String!
    var anotherEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var someScreenClass: String!
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
        someScreenClass = "some screen class"
        anotherScreenName = "another screen name"
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        anotherEvent = EventMock(name: anotherEventName)
        someScreen = FirebaseAnalyticsScreenMock()
        someScreen.name = someScreenName
        someScreen.screenClass = someScreenClass
        anotherScreen = ScreenMock(name: anotherScreenName)

        adapter = FirebaseAnalyticsServiceAdapterMock.self
        sut = FirebaseAnalyticsServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventNameStringParametersStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventNameStringParametersStringAnyVoidReceivedArguments?.name, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.logEventNameStringParametersStringAnyVoidReceivedArguments?.parameters?[key] as? String, value)
        }
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.setUserPropertyValueStringForNameStringVoidCalled)
        XCTAssertEqual(adapter.setUserPropertyValueStringForNameStringVoidReceivedArguments?.forName, somePropertyKey)
        XCTAssertEqual(adapter.setUserPropertyValueStringForNameStringVoidReceivedArguments?.value, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(adapter.setUserPropertyValueStringForNameStringVoidCallsCount, 2)
        XCTAssertEqual(adapter.setUserPropertyValueStringForNameStringVoidReceivedArguments?.forName, somePropertyKey)
        XCTAssertNil(adapter.setUserPropertyValueStringForNameStringVoidReceivedArguments?.value)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.setUserIDUserIdStringVoidCalled)
        XCTAssertEqual(adapter.setUserIDUserIdStringVoidReceivedUserId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.setUserIDUserIdStringVoidCalled)
        XCTAssertNil(adapter.setUserIDUserIdStringVoidReceivedUserId)
    }

    func testDisableTracking() throws {
        sut.disableTracking(true)
        XCTAssertTrue(adapter.setAnalyticsCollectionEnabledEnabledBoolVoidCalled)
        try AssertFalse(adapter.setAnalyticsCollectionEnabledEnabledBoolVoidReceivedEnabled)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() throws {
        sut.disableTracking(false)
        XCTAssertTrue(adapter.setAnalyticsCollectionEnabledEnabledBoolVoidCalled)
        try AssertTrue(adapter.setAnalyticsCollectionEnabledEnabledBoolVoidReceivedEnabled)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
