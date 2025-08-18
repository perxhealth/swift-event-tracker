@testable import Tracker
@testable import TrackerTesting
import XCTest

final class FacebookServiceProviderShould: XCTestCase {
    var sut: FacebookServiceProvider!
    var adapter: FacebookServiceAdapterMock!
    var settingsAdapter: FacebookSettingsAdapterMock!

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
        someScreen = ScreenMock()
        someScreen.name = someScreenName

        adapter = FacebookServiceAdapterMock()
        settingsAdapter = FacebookSettingsAdapterMock()
        sut = FacebookServiceProvider(adapter: adapter, settingsAdapter: settingsAdapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.facebook, .analytics, .nativeEventParameters, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
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
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.logEventEventNameStringParametersStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringParametersStringAnyVoidReceivedArguments?.eventName, "Set property")
    }

    func testRemovePropertiesOnResetProperties() throws {
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
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
