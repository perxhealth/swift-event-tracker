@testable import Tracker
@testable import TrackerTesting
import XCTest

final class BugseeServiceProviderShould: XCTestCase {
    var sut: BugseeServiceProvider!
    var adapter: BugseeServiceAdapterMock.Type!

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

        BugseeServiceAdapterMock.reset()
        adapter = BugseeServiceAdapterMock.self
        sut = BugseeServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.bugsee, .crashReporting, .nativeEventParameters, .nativeProperties])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.eventEventNameStringParamsAnyHashableAnyVoidCalled)
        XCTAssertEqual(adapter.eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
            XCTAssertEqual(adapter.eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments?.params[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.eventEventNameStringParamsAnyHashableAnyVoidCalled)
        try AssertTrue(adapter.eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.setAttributeKeyStringValueAnyBoolCalled)
        XCTAssertEqual(adapter.setAttributeKeyStringValueAnyBoolReceivedArguments?.key, somePropertyKey)
        XCTAssertEqual(adapter.setAttributeKeyStringValueAnyBoolReceivedArguments?.value as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        adapter.clearAllAttributeBoolReturnValue = true
        adapter.setAttributeKeyStringValueAnyBoolReturnValue = true
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.clearAllAttributeBoolCalled)
    }

    func testSetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey] as? String, someUserId)
    }

    func testSetUserIdSetsExpectedProperty() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertTrue(adapter.setAttributeKeyStringValueAnyBoolCalled)
        XCTAssertEqual(adapter.setAttributeKeyStringValueAnyBoolReceivedArguments?.key, AbstractProvider.defaultFallbackUserIdPropertyKey)
        XCTAssertEqual(adapter.setAttributeKeyStringValueAnyBoolReceivedArguments?.value as? String, someUserId)
    }

    func testResetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.setAttributeKeyStringValueAnyBoolCalled)
        XCTAssertEqual(adapter.setAttributeKeyStringValueAnyBoolReceivedArguments?.key, AbstractProvider.defaultFallbackUserIdPropertyKey)
        XCTAssertEqual(adapter.setAttributeKeyStringValueAnyBoolReceivedArguments?.value as? String, "")
        XCTAssertNil(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey])
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
