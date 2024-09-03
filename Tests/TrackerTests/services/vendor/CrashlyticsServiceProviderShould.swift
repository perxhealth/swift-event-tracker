@testable import Tracker
import TrackerTesting
import XCTest

final class CrashlyticsServiceProviderShould: XCTestCase {
    var sut: CrashlyticsServiceProvider!
    var adapter: CrashlyticsServiceAdapterMock!

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

        adapter = CrashlyticsServiceAdapterMock()
        sut = CrashlyticsServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logMsgStringVoidCalled)
        XCTAssertEqual(adapter.logMsgStringVoidReceivedMsg, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(adapter.setCustomValueValueAnyForKeyStringVoidCallsCount, 2)
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logMsgStringVoidCalled)
        try AssertTrue(adapter.logMsgStringVoidReceivedMsg?.hasPrefix(someScreenName))
        try AssertTrue(adapter.logMsgStringVoidReceivedMsg?.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.setCustomValueValueAnyForKeyStringVoidCalled)
        XCTAssertEqual(adapter.setCustomValueValueAnyForKeyStringVoidReceivedArguments?.forKey, somePropertyKey)
        XCTAssertEqual(adapter.setCustomValueValueAnyForKeyStringVoidReceivedArguments?.value as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(adapter.setCustomValueValueAnyForKeyStringVoidReceivedArguments?.forKey, somePropertyKey)
        XCTAssertEqual(adapter.setCustomValueValueAnyForKeyStringVoidReceivedArguments?.value as? String, "")
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
        XCTAssertEqual(adapter.setUserIDUserIdStringVoidReceivedUserId, "")
    }

    func testDisableTracking() throws {
        sut.disableTracking(true)
        XCTAssertTrue(adapter.setCrashlyticsCollectionEnabledFlagBoolVoidCalled)
        try AssertFalse(adapter.setCrashlyticsCollectionEnabledFlagBoolVoidReceivedFlag)
        adapter.isCrashlyticsCollectionEnabledBoolReturnValue = false
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() throws {
        sut.disableTracking(false)
        XCTAssertTrue(adapter.setCrashlyticsCollectionEnabledFlagBoolVoidCalled)
        try AssertTrue(adapter.setCrashlyticsCollectionEnabledFlagBoolVoidReceivedFlag)
        adapter.isCrashlyticsCollectionEnabledBoolReturnValue = true
        XCTAssertFalse(sut.trackingDisabled)
    }
}
