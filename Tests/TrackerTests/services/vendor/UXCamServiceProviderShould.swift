@testable import Tracker
@testable import TrackerTesting
import XCTest

final class UXCamServiceProviderShould: XCTestCase {
    var sut: UXCamServiceProvider!
    var adapter: UXCamServiceAdapterMock.Type!

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

        UXCamServiceAdapterMock.reset()
        adapter = UXCamServiceAdapterMock.self
        sut = UXCamServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.uxCam, .analytics, .nativeEventParameters, .nativeProperties, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logEventEventNameStringWithPropertiesStringAnyVoidCalled)
        XCTAssertEqual(adapter.logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments?.eventName, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            XCTAssertEqual(adapter.logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments?.withProperties?[key] as? String, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logEventEventNameStringWithPropertiesStringAnyVoidCalled)
        try AssertTrue(adapter.logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments?.eventName.hasPrefix(someScreenName))
        try AssertTrue(adapter.logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments?.eventName.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.setUserPropertyPropertyNameStringValueAnyVoidCalled)
        XCTAssertEqual(adapter.setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments?.propertyName as? String, somePropertyKey)
        XCTAssertEqual(adapter.setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments?.value as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.setUserPropertyPropertyNameStringValueAnyVoidCalled)
        XCTAssertEqual(adapter.setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments?.propertyName, somePropertyKey)
        XCTAssertEqual(adapter.setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments?.value as? String, "")
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertTrue(adapter.setUserIdentityUserIdentityStringVoidCalled)
        XCTAssertEqual(adapter.setUserIdentityUserIdentityStringVoidReceivedUserIdentity, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.setUserIdentityUserIdentityStringVoidCalled)
        XCTAssertEqual(adapter.setUserIdentityUserIdentityStringVoidReceivedUserIdentity, "")
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        adapter.optInOverallStatusBoolReturnValue = false
        XCTAssertTrue(adapter.optOutOverallVoidCalled)
        XCTAssertFalse(adapter.optInOverallVoidCalled)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        adapter.optInOverallStatusBoolReturnValue = true
        XCTAssertTrue(adapter.optInOverallVoidCalled)
        XCTAssertFalse(adapter.optOutOverallVoidCalled)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
