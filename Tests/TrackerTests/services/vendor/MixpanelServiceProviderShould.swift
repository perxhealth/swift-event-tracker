@testable import Tracker
@testable import TrackerTesting
import XCTest

final class MixpanelServiceProviderShould: XCTestCase {
    var sut: MixpanelServiceProvider!
    var adapter: MixpanelServiceAdapterMock!

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
        someScreen = ScreenMock(name: someScreenName)

        adapter = MixpanelServiceAdapterMock()
        sut = MixpanelServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.mixpanel, .analytics, .nativeEventParameters, .nativeProperties, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.trackEventStringPropertiesAnyHashableAnyVoidCalled)
        XCTAssertEqual(adapter.trackEventStringPropertiesAnyHashableAnyVoidReceivedArguments?.event, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.trackEventStringPropertiesAnyHashableAnyVoidReceivedArguments?.properties?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.trackEventStringPropertiesAnyHashableAnyVoidCalled)
        try AssertTrue(adapter.trackEventStringPropertiesAnyHashableAnyVoidReceivedArguments?.event.hasPrefix(someScreenName))
        try AssertTrue(adapter.trackEventStringPropertiesAnyHashableAnyVoidReceivedArguments?.event.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.setPropertyStringToValueStringVoidCalled)
        XCTAssertEqual(adapter.setPropertyStringToValueStringVoidReceivedArguments?.property, somePropertyKey)
        XCTAssertEqual(adapter.setPropertyStringToValueStringVoidReceivedArguments?.value, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.unsetPropertiesStringVoidCalled)
        XCTAssertEqual(adapter.unsetPropertiesStringVoidReceivedProperties, [somePropertyKey])
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.identifyDistinctIdStringVoidReceivedDistinctId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.resetUserIdVoidCalled)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertTrue(adapter.optOutTrackingVoidCalled)
        adapter.hasOptedOutTrackingBoolReturnValue = true
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(true)
        sut.disableTracking(false)
        XCTAssertTrue(adapter.optInTrackingVoidCalled)
        adapter.hasOptedOutTrackingBoolReturnValue = false
        XCTAssertFalse(sut.trackingDisabled)
    }
}
