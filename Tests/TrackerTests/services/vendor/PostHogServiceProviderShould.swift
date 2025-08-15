@testable import Tracker
@testable import TrackerTesting
import XCTest

final class PostHogServiceProviderShould: XCTestCase {
    var sut: PostHogServiceProvider!
    var adapter: PostHogServiceAdapterMock!

    var someEvent: EventMock!
    var someScreen: PostHogScreenMock!
    var anotherScreen: ScreenMock!

    var someEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var someScreenProperties: [String: String]!
    var anotherScreenName: String!
    var somePropertyKey: String!
    var somePropertyValue: String!
    var someUserId: String!

    var receivedEventDescription: String?

    override func setUp() {
        super.setUp()
        someEventName = "some event name"
        parameters = ["param0": "value0", "param1": "value1"]
        someScreenName = "some screen name"
        someScreenProperties = ["some key": "some value"]
        anotherScreenName = "another screen name"
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        someScreen = PostHogScreenMock()
        someScreen.name = someScreenName
        someScreen.properties = someScreenProperties
        anotherScreen = ScreenMock(name: anotherScreenName)

        adapter = PostHogServiceAdapterMock()
        sut = PostHogServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.postHog, .analytics, .nativeEventParameters, .nativeProperties, .nativeScreen, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(adapter.captureEventStringPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.captureEventStringPropertiesStringAnyVoidReceivedArguments?.event, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
            XCTAssertEqual(adapter.captureEventStringPropertiesStringAnyVoidReceivedArguments?.properties?[key] as! String, value)
        }
    }

    func testTrackScreenWithExpectedName() {
        sut.trackScreen(anotherScreen)
        XCTAssertEqual(adapter.screenScreenTitleStringPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.screenScreenTitleStringPropertiesStringAnyVoidReceivedArguments?.screenTitle, anotherScreenName)
    }

    func testTrackScreenWithExpectedProperties() {
        sut.trackScreen(someScreen)
        XCTAssertEqual(adapter.screenScreenTitleStringPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.screenScreenTitleStringPropertiesStringAnyVoidReceivedArguments?.screenTitle, someScreenName)
        for (key, value) in someScreen.properties {
            XCTAssertEqual(adapter.screenScreenTitleStringPropertiesStringAnyVoidReceivedArguments?.properties?[key] as! String, value as! String)
        }
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertEqual(adapter.registerPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.registerPropertiesStringAnyVoidReceivedProperties?[somePropertyKey] as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(adapter.registerPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.unregisterKeyStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.unregisterKeyStringVoidReceivedKey, somePropertyKey)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.identifyDistinctIdStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.identifyDistinctIdStringVoidReceivedDistinctId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertEqual(adapter.resetVoidCallsCount, 1)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertEqual(adapter.optOutVoidCallsCount, 1)
        adapter.isOptOutBoolReturnValue = true
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertEqual(adapter.optInVoidCallsCount, 1)
        adapter.isOptOutBoolReturnValue = false
        XCTAssertFalse(sut.trackingDisabled)
    }
}
