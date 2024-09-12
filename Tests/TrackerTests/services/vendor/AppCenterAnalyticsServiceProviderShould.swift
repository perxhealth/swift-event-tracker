@testable import Tracker
@testable import TrackerTesting
import XCTest

final class AppCenterAnalyticsServiceProviderShould: XCTestCase {
    var sut: AppCenterAnalyticsServiceProvider!
    var adapter: AppCenterAnalyticsServiceAdapterMock.Type!

    var someEvent: EventMock!
    var anotherEvent: EventMock!
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

        AppCenterAnalyticsServiceAdapterMock.reset()
        adapter = AppCenterAnalyticsServiceAdapterMock.self
        sut = AppCenterAnalyticsServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.appCenterAnalytics, .analytics, .nativeEventParameters])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?[key], value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        try AssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetExpectedPropertyTracksEventWithExpectedEventName() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName, "Set property")
    }

    func testSetExpectedPropertyTracksEventWithExpectedParameters() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?[somePropertyKey], somePropertyValue)
    }

    func testResetPropertiesTracksEventWithExpectedEventName() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName, "Reset properties")
    }

    func testResetPropertiesTracksEventWithExpectedParameters() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?["keys"], somePropertyKey)
    }

    func testSetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey] as? String, someUserId)
    }

    func testSetUserIdTracksEventWithExpectedEventName() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName, "Set property")
    }

    func testSetUserIdTracksEventWithExpectedParameters() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?[AbstractProvider.defaultFallbackUserIdPropertyKey], someUserId)
    }

    func testResetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertNil(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey])
    }

    func testResetUserIdTracksEventWithExpectedEventName() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.eventName, "Set property")
    }

    func testResetUserIdTracksEventWithExpectedParameters() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments?.properties?[AbstractProvider.defaultFallbackUserIdPropertyKey], "")
    }

    func testDisableTrackingTracksEventWithExpectedEventName() {
        sut.disableTracking(true)
        XCTAssertTrue(sut.trackingDisabled)
        XCTAssertTrue(adapter.pauseVoidCalled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(sut.trackingDisabled)
        XCTAssertTrue(adapter.resumeVoidCalled)
    }
}
