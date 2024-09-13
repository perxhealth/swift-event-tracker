@testable import Tracker
@testable import TrackerTesting
import XCTest

final class HeapFlyerServiceProviderShould: XCTestCase {
    var sut: HeapServiceProvider!
    var adapter: HeapServiceAdapterMock.Type!

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

        HeapServiceAdapterMock.reset()
        adapter = HeapServiceAdapterMock.self
        sut = HeapServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.heap, .analytics, .nativeEventParameters, .nativeProperties, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(adapter.trackEventStringWithPropertiesPropertiesAnyHashableAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.trackEventStringWithPropertiesPropertiesAnyHashableAnyVoidReceivedArguments?.event, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.trackEventStringWithPropertiesPropertiesAnyHashableAnyVoidReceivedArguments?.properties?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertEqual(adapter.trackEventStringWithPropertiesPropertiesAnyHashableAnyVoidCallsCount, 1)
        try AssertTrue(adapter.trackEventStringWithPropertiesPropertiesAnyHashableAnyVoidReceivedArguments?.event.hasPrefix(someScreenName))
        try AssertTrue(adapter.trackEventStringWithPropertiesPropertiesAnyHashableAnyVoidReceivedArguments?.event.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        for (key, value) in adapter.addUserPropertiesPropertiesStringAnyVoidReceivedProperties ?? [:] {
            XCTAssertEqual(key, somePropertyKey)
            XCTAssertEqual(value as? String, somePropertyValue)
        }
    }

    func testRemovePropertiesOnResetProperties() throws {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        try AssertTrue(adapter.addUserPropertiesPropertiesStringAnyVoidReceivedProperties?.isEmpty)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.identifyIdentityStringVoidReceivedIdentity, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertEqual(adapter.resetIdentityVoidCallsCount, 1)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        adapter.isTrackingEnabledBoolReturnValue = false
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        adapter.isTrackingEnabledBoolReturnValue = true
        XCTAssertFalse(sut.trackingDisabled)
    }
}
