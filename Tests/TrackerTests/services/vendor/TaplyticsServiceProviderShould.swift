@testable import Tracker
@testable import TrackerTesting
import XCTest

final class TaplyticsServiceProviderShould: XCTestCase {
    var sut: TaplyticsServiceProvider!
    var adapter: TaplyticsServiceAdapterMock.Type!

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

        TaplyticsServiceAdapterMock.reset()
        adapter = TaplyticsServiceAdapterMock.self
        sut = TaplyticsServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.taplytics, .analytics, .nativeProperties])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventEventNameStringVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringVoidReceivedEventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() throws {
        sut.trackEvent(someEvent)
        let attributes = adapter.setUserAttributesAttributesAnyHashableAnyVoidReceivedAttributes ?? [:]
        XCTAssertEqual(attributes["customData"] as? [String: String], ["some event name -> param1": "value1", "some event name -> param0": "value0"])
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logEventEventNameStringVoidCalled)
        try AssertTrue(adapter.logEventEventNameStringVoidReceivedEventName?.hasPrefix(someScreenName))
        try AssertTrue(adapter.logEventEventNameStringVoidReceivedEventName?.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.setUserAttributesAttributesAnyHashableAnyVoidCalled)
        for (key, value) in adapter.setUserAttributesAttributesAnyHashableAnyVoidReceivedAttributes?["customData"] as? [String: Any] ?? [:] {
            XCTAssertEqual(key, somePropertyKey)
            XCTAssertEqual(value as? String, somePropertyValue)
        }
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.setUserAttributesAttributesAnyHashableAnyVoidCalled)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.setUserAttributesAttributesAnyHashableAnyVoidCalled)
        XCTAssertEqual(adapter.setUserAttributesAttributesAnyHashableAnyVoidReceivedAttributes?["user_id"] as? String, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.setUserAttributesAttributesAnyHashableAnyVoidCalled)
        XCTAssertNil(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey])
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        adapter.hasUserOptedOutTrackingBoolReturnValue = true
        XCTAssertTrue(adapter.optOutUserTrackingVoidCalled)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        adapter.hasUserOptedOutTrackingBoolReturnValue = false
        XCTAssertTrue(adapter.optInUserTrackingVoidCalled)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
