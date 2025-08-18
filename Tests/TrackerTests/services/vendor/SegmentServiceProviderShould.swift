@testable import Tracker
@testable import TrackerTesting
import XCTest

final class SegmentServiceProviderShould: XCTestCase {
    var sut: SegmentServiceProvider!
    var adapter: SegmentServiceAdapterMock!

    var someEvent: EventMock!
    var someScreen: SegmentScreenMock!
    var anotherScreen: ScreenMock!

    var someEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var someScreenProperties: [String: String]!
    var anotherScreenName: String!
    var somePropertyKey: String!
    var somePropertyValue: String!
    var someUserId: String!

    var receivedEventDescription: String?

    override func setUp() {
        super.setUp()
        someEventName = "some event name"
        parameters = ["param0": "value0", "param1": "value1"]
        someScreenName = "some screen name"
        someScreenProperties = ["some key": "some value"]
        anotherScreenName = "another screen name"
        somePropertyKey = "some property key"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someEvent = EventMock(name: someEventName, parameters: parameters)
        someScreen = SegmentScreenMock()
        someScreen.name = someScreenName
        someScreen.properties = someScreenProperties
        anotherScreen = ScreenMock(name: anotherScreenName)

        adapter = SegmentServiceAdapterMock()
        sut = SegmentServiceProvider(adapter: adapter)
    }

    override func tearDown() {
        super.tearDown()
        receivedEventDescription = nil
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.segment, .analytics, .nativeEventParameters, .nativeProperties, .nativeScreen, .nativeUserId])
    }

    func testTrackEventWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(adapter.trackNameStringPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.trackNameStringPropertiesStringAnyVoidReceivedArguments?.name, someEventName)
    }

    func testTrackEventWithExpectedParameters() {
        sut.trackEvent(someEvent)
        for (key, value) in someEvent.resolvedParameters {
            XCTAssertEqual(adapter.trackNameStringPropertiesStringAnyVoidReceivedArguments?.properties[key] as! String, value)
        }
    }

    func testTrackScreenWithExpectedName() {
        sut.trackScreen(anotherScreen)
        XCTAssertEqual(adapter.trackScreenTitleStringCategoryStringPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.trackScreenTitleStringCategoryStringPropertiesStringAnyVoidReceivedArguments?.title, anotherScreenName)
    }

    func testTrackScreenWithExpectedSegmentation() {
        sut.trackScreen(someScreen)
        XCTAssertEqual(adapter.trackScreenTitleStringCategoryStringPropertiesStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.trackScreenTitleStringCategoryStringPropertiesStringAnyVoidReceivedArguments?.title, someScreenName)
        for (key, value) in someScreen.properties {
            XCTAssertEqual(adapter.trackScreenTitleStringCategoryStringPropertiesStringAnyVoidReceivedArguments?.properties[key] as! String, value as! String)
        }
    }

    func testSetExpectedProperty() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(sut.userProperties[somePropertyKey] as? String, somePropertyValue)
        XCTAssertEqual(adapter.setTraitsTraitsStringAnyVoidCallsCount, 1)
        XCTAssertEqual(adapter.setTraitsTraitsStringAnyVoidReceivedTraits?[somePropertyKey] as? String, somePropertyValue)
    }

    func testRemovePropertiesOnResetProperties() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        sut.resetProperties()
        XCTAssertEqual(adapter.setTraitsTraitsStringAnyVoidCallsCount, 2)
        XCTAssertEqual(adapter.setTraitsTraitsStringAnyVoidReceivedTraits?.count, 0)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(adapter.setUserIdUserIdStringVoidCallsCount, 1)
        XCTAssertEqual(adapter.setUserIdUserIdStringVoidReceivedUserId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertEqual(adapter.setUserIdUserIdStringVoidCallsCount, 2)
        XCTAssertNil(adapter.setUserIdUserIdStringVoidReceivedUserId)
    }

    func testDisableTracking() {
        sut.disableTracking(true)
        XCTAssertFalse(adapter.enabled)
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testEnableTracking() {
        sut.disableTracking(false)
        XCTAssertTrue(adapter.enabled)
        XCTAssertFalse(sut.trackingDisabled)
    }
}
