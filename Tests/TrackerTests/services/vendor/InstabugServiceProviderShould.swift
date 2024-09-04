@testable import Tracker
@testable import TrackerTesting
import XCTest

final class InstabugServiceProviderShould: XCTestCase {
    var sut: InstabugServiceProvider!
    var adapter: InstabugServiceAdapterMock.Type!

    var someEvent: EventMock!
    var anotherEvent: EventMock!
    var someScreen: ScreenMock!
    var anotherScreen: ScreenMock!

    var someEventName: String!
    var anotherEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var anotherScreenName: String!
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
        anotherScreenName = "another screen name"
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        anotherEvent = EventMock(name: anotherEventName)
        someScreen = ScreenMock()
        someScreen.name = someScreenName
        anotherScreen = ScreenMock(name: anotherScreenName)

        InstabugServiceAdapterMock.reset()
        adapter = InstabugServiceAdapterMock.self
        sut = InstabugServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.instabug, .crashReporting, .nativeProperties])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertTrue(adapter.logUserEventWithNameStringVoidCalled)
        XCTAssertEqual(adapter.logUserEventWithNameStringVoidReceivedWithName, someEventName)
    }

    func testTrackEventWithExpectedParameters() throws {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.parameters {
            let invocation = adapter.setUserAttributeValueStringWithKeyStringVoidReceivedInvocations.first { (_, withKey) in
                withKey.hasSuffix(key)
            }
            try AssertTrue(invocation?.withKey.hasPrefix(someEvent.name + " -> "))
            XCTAssertEqual(invocation?.value, value)
        }
    }

    func testTrackEventWithExpectedScreenName() throws {
        sut.trackScreen(someScreen)
        XCTAssertTrue(adapter.logUserEventWithNameStringVoidCalled)
        try AssertTrue(adapter.logUserEventWithNameStringVoidReceivedWithName?.hasPrefix(someScreenName))
        try AssertTrue(adapter.logUserEventWithNameStringVoidReceivedWithName?.hasSuffix(" viewed"))
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertTrue(adapter.setUserAttributeValueStringWithKeyStringVoidCalled)
        XCTAssertEqual(adapter.setUserAttributeValueStringWithKeyStringVoidReceivedArguments?.withKey, somePropertyKey)
        XCTAssertEqual(adapter.setUserAttributeValueStringWithKeyStringVoidReceivedArguments?.value as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(sut.userProperties.count, 0)
        XCTAssertTrue(adapter.removeUserAttributeForKeyStringVoidCalled)
    }

    func testSetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties[AbstractProvider.defaultFallbackUserIdPropertyKey] as? String, someUserId)
    }

    func testSetUserIdSetsExpectedProperty() {
        sut.setUserId(someUserId)
        XCTAssertEqual(sut.userProperties.count, 1)
        XCTAssertTrue(adapter.setUserAttributeValueStringWithKeyStringVoidCalled)
        XCTAssertEqual(adapter.setUserAttributeValueStringWithKeyStringVoidReceivedArguments?.withKey, AbstractProvider.defaultFallbackUserIdPropertyKey)
        XCTAssertEqual(adapter.setUserAttributeValueStringWithKeyStringVoidReceivedArguments?.value as? String, someUserId)
    }

    func testResetUserIdUpdatesUserProperties() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertTrue(adapter.setUserAttributeValueStringWithKeyStringVoidCalled)
        XCTAssertEqual(adapter.setUserAttributeValueStringWithKeyStringVoidReceivedArguments?.withKey, AbstractProvider.defaultFallbackUserIdPropertyKey)
        XCTAssertEqual(adapter.setUserAttributeValueStringWithKeyStringVoidReceivedArguments?.value as? String, "")
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
