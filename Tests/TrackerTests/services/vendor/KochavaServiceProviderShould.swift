@testable import Tracker
@testable import TrackerTesting
import XCTest

final class KochavaServiceProviderShould: XCTestCase {
    var sut: KochavaServiceProvider!
    var adapter: KochavaServiceAdapterMock!

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

        adapter = KochavaServiceAdapterMock()
        sut = KochavaServiceProvider(adapter: adapter, identityLinkName: "some identity name")
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.kochava, .analytics, .nativeEventParameters, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidReceivedArguments?.name, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
            XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidReceivedArguments?.infoDictionary?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidCallsCount, 1)
        try AssertTrue(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidReceivedArguments?.name.hasPrefix(someScreenName))
        try AssertTrue(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidReceivedArguments?.name.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidReceivedArguments?.name, "Set property")
    }

    func testRemovePropertiesOnResetProperties() throws {
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.sendCustomEventNameStringInfoDictionaryAnyHashableAnyVoidReceivedArguments?.name, "Reset properties")
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.registerIdentityLinkNameStringIdentifierStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.registerIdentityLinkNameStringIdentifierStringVoidReceivedArguments?.name, "some identity name")
        XCTAssertEqual(adapter.registerIdentityLinkNameStringIdentifierStringVoidReceivedArguments?.identifier, someUserId)
    }

    func testResetUserId() throws {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertEqual(adapter.registerIdentityLinkNameStringIdentifierStringVoidCallsCount, 2)
        XCTAssertEqual(adapter.registerIdentityLinkNameStringIdentifierStringVoidReceivedArguments?.name, "some identity name")
        XCTAssertNil(adapter.registerIdentityLinkNameStringIdentifierStringVoidReceivedArguments?.identifier)
    }

    func testDisableTracking() throws {
        sut.disableTracking(true)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() throws {
        sut.disableTracking(false)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
