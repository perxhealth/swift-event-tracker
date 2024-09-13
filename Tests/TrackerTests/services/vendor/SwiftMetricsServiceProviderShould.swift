@testable import Tracker
@testable import TrackerTesting
import XCTest

final class SwiftMetricsServiceProviderShould: XCTestCase {
    var sut: SwiftMetricsServiceProvider!
    var adapter: SwiftMetricsServiceAdapterMock.Type!

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

        SwiftMetricsServiceAdapterMock.reset()
        adapter = SwiftMetricsServiceAdapterMock.self
        sut = SwiftMetricsServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.swiftMetrics, .analytics, .nativeEventParameters])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.first { (name, _) in key == name }?.1, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        try AssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label.hasPrefix(someScreenName))
        try AssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label.hasSuffix(" viewed"))
    }

    func testSetPropertyUpdatesUserProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
    }

    func testSetPropertyTracksEventWithExpectedEventName() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label, "Set property")
    }

    func testSetPropertyTracksEventWithExpectedParameters() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.count, 1)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.first { (name, _) in somePropertyKey == name }?.1, somePropertyValue)
    }

    func testResetPropertiesRemovesUserProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
    }

    func testResetPropertiesTracksEventWithExpectedEventName() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label, "Reset properties")
    }

    func testResetPropertiesTracksEventWithExpectedParameters() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.count, 1)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.first { (name, _) in "keys" == name }?.1, somePropertyKey)
    }

    func testSetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey] as? String, someUserId)
    }

    func testSetUserIdTracksEventWithExpectedEventName() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label, "Set property")
    }

    func testSetUserIdTracksEventWithExpectedParameters() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.count, 1)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.first { (name, _) in AbstractProvider.defaultFallbackUserIdPropertyKey == name }?.1, someUserId)
    }

    func testResetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertNil(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey])
    }

    func testResetUserIdTracksEventWithExpectedEventName() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.label, "Set property")
    }

    func testResetUserIdTracksEventWithExpectedParameters() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.incrementCounterLabelStringDimensionsStringStringVoidCalled)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.count, 1)
        XCTAssertEqual(adapter.incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments?.dimensions.first { (name, _) in AbstractProvider.defaultFallbackUserIdPropertyKey == name }?.1, "")
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
