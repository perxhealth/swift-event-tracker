@testable import Tracker
import TrackerTesting
import XCTest

final class FacebookServiceProviderShould: XCTestCase {
    var sut: FacebookServiceProvider!
    var adapter: FacebookServiceAdapterMock!
    var settingsAdapter: FacebookSettingsAdapterMock!

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

        adapter = FacebookServiceAdapterMock()
        settingsAdapter = FacebookSettingsAdapterMock()
        sut = FacebookServiceProvider(adapter: adapter, settingsAdapter: settingsAdapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.parameters[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidCalled)
        try AssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName, "Set property")
    }

    func testRemovePropertiesOnResetProperties() throws {
        sut.resetProperties()
        XCTAssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName, "Reset properties")
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.userID, someUserId)
    }

    func testResetUserId() throws {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertNil(adapter.userID)
    }

    func testDisableTracking() throws {
        sut.disableTracking(true)
        XCTAssertTrue(settingsAdapter.isAutoLogAppEventsEnabled)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() throws {
        sut.disableTracking(false)
        XCTAssertFalse(settingsAdapter.isAutoLogAppEventsEnabled)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
