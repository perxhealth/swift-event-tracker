@testable import Tracker
@testable import TrackerTesting
import XCTest

final class AmplitudeServiceProviderShould: XCTestCase {
    var sut: AmplitudeServiceProvider!
    var adapter: AmplitudeServiceAdapterMock!

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

        adapter = AmplitudeServiceAdapterMock()
        sut = AmplitudeServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.amplitude, .analytics, .nativeEventParameters, .nativeProperties, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedArguments?.eventType, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
            XCTAssertEqual(adapter.logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedArguments?.withEventProperties?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidCalled)
        try AssertTrue(adapter.logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedArguments?.eventType.hasPrefix(someScreenName))
        try AssertTrue(adapter.logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedArguments?.eventType.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.setUserPropertiesDictionaryAnyHashableAnyVoidCalled)
        for (key, value) in adapter.setUserPropertiesDictionaryAnyHashableAnyVoidReceivedDictionary ?? [:] {
            XCTAssertEqual(key.base as? String, somePropertyKey)
            XCTAssertEqual(value as? String, somePropertyValue)
        }
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.clearUserPropertiesVoidCalled)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.setUserIdIdStringVoidCalled)
        XCTAssertEqual(adapter.setUserIdIdStringVoidReceivedId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.setUserIdIdStringVoidCalled)
        XCTAssertNil(adapter.setUserIdIdStringVoidReceivedId)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertTrue(adapter.optOut)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(adapter.optOut)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
