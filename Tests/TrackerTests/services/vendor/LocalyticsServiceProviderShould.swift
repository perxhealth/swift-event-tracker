@testable import Tracker
@testable import TrackerTesting
import XCTest

final class LocalyticsServiceProviderShould: XCTestCase {
    var sut: LocalyticsServiceProvider!
    var adapter: LocalyticsServiceAdapterMock.Type!

    var someEvent: EventMock!
    var anotherEvent: EventMock!
    var someScreen: ScreenMock!

    var someEventName: String!
    var anotherEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var someScreenProperties: [String: String]!
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
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        anotherEvent = EventMock(name: anotherEventName)
        someScreen = ScreenMock(name: someScreenName)

        LocalyticsServiceAdapterMock.reset()
        adapter = LocalyticsServiceAdapterMock.self
        sut = LocalyticsServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.localytics, .analytics, .nativeEventParameters, .nativeProperties, .nativeScreen, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(adapter.tagEventEventNameStringAttributesStringStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.tagEventEventNameStringAttributesStringStringVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.tagEventEventNameStringAttributesStringStringVoidReceivedArguments?.attributes?[key] as! String, value)
        }
    }

    func testTrackScreenWithExpectedName() {
        sut.trackScreen(someScreen)
        XCTAssertEqual(adapter.tagScreenScreenNameStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.tagScreenScreenNameStringVoidReceivedScreenName, someScreenName)
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertEqual(adapter.setValueValueStringForIdentifierStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.setValueValueStringForIdentifierStringVoidReceivedArguments?.forIdentifier as? String, somePropertyKey)
        XCTAssertEqual(adapter.setValueValueStringForIdentifierStringVoidReceivedArguments?.value as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(adapter.setValueValueStringForIdentifierStringVoidCallsCount, 2)
        XCTAssertEqual(adapter.setValueValueStringForIdentifierStringVoidReceivedArguments?.forIdentifier as? String, somePropertyKey)
        XCTAssertNil(adapter.setValueValueStringForIdentifierStringVoidReceivedArguments?.value)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.setCustomerIdCustomerIdStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.setCustomerIdCustomerIdStringVoidReceivedCustomerId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertEqual(adapter.setCustomerIdCustomerIdStringVoidCallsCount, 2)
        XCTAssertNil(adapter.setCustomerIdCustomerIdStringVoidReceivedCustomerId)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertEqual(adapter.setOptedOutOptedOutBoolVoidCallsCount, 1)
        XCTAssertEqual(adapter.setOptedOutOptedOutBoolVoidReceivedOptedOut, true)
        XCTAssertEqual(adapter.setPrivacyOptedOutOptedOutBoolVoidCallsCount, 1)
        XCTAssertEqual(adapter.setPrivacyOptedOutOptedOutBoolVoidReceivedOptedOut, true)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertEqual(adapter.setOptedOutOptedOutBoolVoidCallsCount, 1)
        XCTAssertEqual(adapter.setOptedOutOptedOutBoolVoidReceivedOptedOut, false)
        XCTAssertEqual(adapter.setPrivacyOptedOutOptedOutBoolVoidCallsCount, 1)
        XCTAssertEqual(adapter.setPrivacyOptedOutOptedOutBoolVoidReceivedOptedOut, false)
    }

    func testComputesTrackingDisabled() {
        adapter.isPrivacyOptedOutBoolReturnValue = false
        adapter.isOptedOutBoolReturnValue = false
        XCTAssertFalse(sut.trackingDisabled)

        adapter.isPrivacyOptedOutBoolReturnValue = false
        adapter.isOptedOutBoolReturnValue = true
        XCTAssertTrue(sut.trackingDisabled)

        adapter.isPrivacyOptedOutBoolReturnValue = true
        adapter.isOptedOutBoolReturnValue = false
        XCTAssertTrue(sut.trackingDisabled)

        adapter.isPrivacyOptedOutBoolReturnValue = true
        adapter.isOptedOutBoolReturnValue = true
        XCTAssertTrue(sut.trackingDisabled)
    }
}
