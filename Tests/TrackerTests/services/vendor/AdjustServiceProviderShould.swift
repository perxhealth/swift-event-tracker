@testable import Tracker
@testable import TrackerTesting
import XCTest

final class AdjustServiceProviderShould: XCTestCase {
    var sut: AdjustServiceProvider!
    var adapter: AdjustServiceAdapterMock.Type!

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

        AdjustServiceAdapterMock.reset()
        adapter = AdjustServiceAdapterMock.self
        sut = AdjustServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.adjust, .analytics, .nativeEventParameters])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters[key], value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        try AssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetPropertyUpdatesUserProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
    }

    func testSetPropertyTracksEventWithExpectedEventName() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName, "Set property")
    }

    func testSetPropertyTracksEventWithExpectedParameters() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters[somePropertyKey], somePropertyValue)
    }

    func testResetPropertiesRemovesUserProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
    }

    func testResetPropertiesTracksEventWithExpectedEventName() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName, "Reset properties")
    }

    func testResetPropertiesTracksEventWithExpectedParameters() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters["keys"], somePropertyKey)
    }

    func testSetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey] as? String, someUserId)
    }

    func testSetUserIdTracksEventWithExpectedEventName() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName, "Set property")
    }

    func testSetUserIdTracksEventWithExpectedParameters() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters[AbstractProvider.defaultFallbackUserIdPropertyKey], someUserId)
    }

    func testResetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertNil(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey])
    }

    func testResetUserIdTracksEventWithExpectedEventName() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.eventName, "Set property")
    }

    func testResetUserIdTracksEventWithExpectedParameters() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.trackEventEventNameStringParametersStringStringVoidCalled)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters.count, 1)
        XCTAssertEqual(adapter.trackEventEventNameStringParametersStringStringVoidReceivedArguments?.parameters[AbstractProvider.defaultFallbackUserIdPropertyKey], "")
    }

    func testDisableTrackingTracksEventWithExpectedEventName() {
        sut.disableTracking(true)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
