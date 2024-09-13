@testable import Tracker
import TrackerTesting
import XCTest

final class EventTrackerShould: XCTestCase {
    var sut: EventTracker!

    var someProvider: ServiceMock!
    var anotherProvider: ServiceMock!
    var someEvent: Event!
    var anotherEvent: Event!
    var debuggingEvent: Event!
    var nonAnalyticsEvent: Event!
    var someScreen: ScreenMock!
    var anotherScreen: ScreenMock!

    var someEventName: String!
    var debuggingEventName: String!
    var nonAnalyticsEventName: String!
    var anotherEventName: String!
    var parameters: [String: String]!
    var someScreenName: String!
    var anotherScreenName: String!
    var somePropertyKey: String!
    var somePropertyValue: String!
    var someUserId: String!

    override func setUp() {
        super.setUp()
        someEventName = "some event name"
        anotherEventName = "another event name"
        debuggingEventName = "debugging event name"
        nonAnalyticsEventName = "non analytics event name"
        parameters = ["param0": "value0", "param1": "value1"]
        someScreenName = "some screen name"
        anotherScreenName = "another screen name"
        somePropertyKey = "some property name"
        somePropertyValue = "some property value"
        someUserId = "some userId"

        someProvider = ServiceMock(tags: [.crashReporting, .debugging])
        anotherProvider = ServiceMock(tags: [.analytics])
        someEvent = NamedEvent(someEventName) + parameters
        anotherEvent = EventMock(name: anotherEventName)
        debuggingEvent = NamedEvent(debuggingEventName) + [.debugging]
        nonAnalyticsEvent = NamedEvent(nonAnalyticsEventName) - [.analytics]
        someScreen = ScreenMock(name: someScreenName)
        anotherScreen = ScreenMock(name: anotherScreenName)

        sut = EventTracker(serviceProviders: [someProvider, anotherProvider])
    }

    func testSetServiceProviders() {
        sut.setServiceProviders([someProvider])
        sut.trackEvent(someEvent)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEvent.name)
        XCTAssertNil(anotherProvider.trackEventEventEventVoidReceivedEvent)
        sut.setServiceProviders([anotherProvider])
        sut.trackEvent(anotherEvent)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEvent.name)
        XCTAssertEqual(anotherProvider.trackEventEventEventVoidReceivedEvent?.name, anotherEvent.name)
    }

    func testDoNotTrackEventIfTrackingDisabled() {
        someProvider.trackingDisabled = true
        sut.trackEvent(NamedEvent("some event"))
        XCTAssertFalse(someProvider.trackEventEventEventVoidCalled)
        XCTAssertTrue(anotherProvider.trackEventEventEventVoidCalled)
    }

    func testTrackEventsOnlyIfConditionIsMet() {
        sut.trackEvent(someEvent, given: { true })
        sut.trackEvent(anotherEvent, given: { false })
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEventName)
        XCTAssertNotEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, anotherEventName)
    }

    func testTrackEventsOnlyIfAutoclosureConditionIsMet() {
        sut.trackEvent(someEvent, given: true)
        sut.trackEvent(anotherEvent, given: false)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEventName)
        XCTAssertNotEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, anotherEventName)
    }

    func testExecuteTrackedEventThenOnlyIfConditionIsMet() {
        var executed = false
        sut.trackEvent(someEvent, given: { true }, then: { executed = true })
        sut.trackEvent(anotherEvent, given: { false }, then: { XCTFail("must not invoke then when given condition is not met") })
        XCTAssertTrue(executed)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEventName)
        XCTAssertNotEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, anotherEventName)
    }

    func testExecuteTrackedEventThenOnlyIfAutoclosureConditionIsMet() {
        var executed = false
        sut.trackEvent(someEvent, given: true, then: executed = true)
        sut.trackEvent(anotherEvent, given: false, then: XCTFail("must not invoke then when given condition is not met"))
        XCTAssertTrue(executed)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEventName)
        XCTAssertNotEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, anotherEventName)
    }

    func testTrackEventsOnlyIfServiceProviderContainsRequiredTags() {
        sut.trackEvent(debuggingEvent)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, debuggingEventName)
        XCTAssertNil(anotherProvider.trackEventEventEventVoidReceivedEvent)
    }

    func testTrackEventsOnlyIfServiceProviderDoesNotContainExcludedTags() {
        sut.trackEvent(nonAnalyticsEvent)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, nonAnalyticsEventName)
        XCTAssertNil(anotherProvider.trackEventEventEventVoidReceivedEvent)
    }

    func testTrackEventsWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.name, someEventName)
        XCTAssertEqual(anotherProvider.trackEventEventEventVoidReceivedEvent?.name, someEventName)
    }

    func testTrackEventsWithExpectedParameters() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(someProvider.trackEventEventEventVoidReceivedEvent?.parameters, parameters)
    }

    func testTrackEventsWithExpectedPropertyKeys() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(someProvider.setPropertyKeyStringValueStringVoidReceivedArguments?.key, somePropertyKey)
    }

    func testTrackEventsWithExpectedPropertyValues() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(someProvider.setPropertyKeyStringValueStringVoidReceivedArguments?.value, somePropertyValue)
    }

    func testDoNotTrackScreenIfTrackingDisabled() {
        someProvider.trackingDisabled = true
        let screen = ScreenMock()
        screen.name = "some screen name"
        sut.trackScreen(screen)
        XCTAssertFalse(someProvider.trackScreenScreenScreenVoidCalled)
        XCTAssertTrue(anotherProvider.trackScreenScreenScreenVoidCalled)
    }

    func testTrackScreensWithExpectedName() {
        sut.trackScreen(someScreen)
        XCTAssertEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, someScreenName)
    }

    func testTrackScreenOnlyIfConditionIsMet() {
        sut.trackScreen(someScreen, given: { true })
        sut.trackScreen(anotherScreen, given: { false })
        XCTAssertEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, someScreenName)
        XCTAssertNotEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, anotherScreenName)
    }

    func testTrackScreenOnlyIfAutoclosureConditionIsMet() {
        sut.trackScreen(someScreen, given: true)
        sut.trackScreen(anotherScreen, given: false)
        XCTAssertEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, someScreenName)
        XCTAssertNotEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, anotherScreenName)
    }

    func testExecuteTrackedScreenOnlyIfConditionIsMet() {
        var executed = false
        sut.trackScreen(someScreen, given: { true }, then: { executed = true })
        sut.trackScreen(anotherScreen, given: { false }, then: { XCTFail("must not invoke then when given condition is not met") })
        XCTAssertTrue(executed)
        XCTAssertEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, someScreenName)
        XCTAssertNotEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, anotherScreenName)
    }

    func testExecuteTrackedScreenOnlyIfAutoclosureConditionIsMet() {
        var executed = false
        sut.trackScreen(someScreen, given: true, then: executed = true)
        sut.trackScreen(anotherScreen, given: false, then: XCTFail("must not invoke then when given condition is not met"))
        XCTAssertTrue(executed)
        XCTAssertEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, someScreenName)
        XCTAssertNotEqual(someProvider.trackScreenScreenScreenVoidReceivedScreen?.name, anotherScreenName)
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(someProvider.setUserIdUserIdStringVoidReceivedUserId, someUserId)
    }

    func testDoNotSetUserIdIfTrackingDisabled() {
        someProvider.trackingDisabled = true
        sut.setUserId(someUserId)
        XCTAssertFalse(someProvider.setUserIdUserIdStringVoidCalled)
        XCTAssertTrue(anotherProvider.setUserIdUserIdStringVoidCalled)
    }

    func testSetExpectedUserIdOnlyIfTagsMatch() {
        sut.setUserId(someUserId, forTags: [.analytics])
        XCTAssertNil(someProvider.setUserIdUserIdStringVoidReceivedUserId)
        XCTAssertEqual(anotherProvider.setUserIdUserIdStringVoidReceivedUserId, someUserId)
    }

    func testResetUserId() {
        sut.setUserId(someUserId)
        sut.resetUserId()
        XCTAssertEqual(someProvider.resetUserIdVoidCallsCount, 1)
    }

    func testForwardSetPropertiesToProviders() {
        sut.setProperty("key", value: "value")
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testDoNotForwardSetetPropertiesToProvidersIfTrackingDisabled() {
        someProvider.trackingDisabled = true
        sut.setProperty("key", value: "value")
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testForwardSetPropertiesToProvidersOnlyIfTagsMatch() {
        sut.setProperty("key", value: "value", forTags: [.debugging])
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertFalse(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testForwardResetPropertiesToProviders() {
        sut.resetProperties()
        XCTAssertTrue(someProvider.resetPropertiesVoidCalled)
    }

    func testForwardResetetPropertiesToProvidersEvenIfTrackingDisabled() {
        someProvider.trackingDisabled = true
        sut.resetProperties()
        XCTAssertTrue(someProvider.resetPropertiesVoidCalled)
        XCTAssertTrue(anotherProvider.resetPropertiesVoidCalled)
    }

    func testForwardResetPropertiesToProvidersOnlyIfTagsMatch() {
        sut.resetProperties(forTags: [.debugging])
        XCTAssertTrue(someProvider.resetPropertiesVoidCalled)
        XCTAssertFalse(anotherProvider.resetPropertiesVoidCalled)
    }

    func testForwardTrackingDisabledToProviders() throws {
        XCTAssertFalse(someProvider.trackingDisabled)
        sut.disableTracking(true)
        try AssertTrue(someProvider.disableTrackingFlagBoolVoidReceivedFlag)
    }

    func testSupportedTags() {
        XCTAssertEqual(sut.supportedTags, [.crashReporting, .debugging, .analytics])
    }

    func testTrackingIsDisabledIfAllProvidersDisabled() {
        someProvider.trackingDisabled = true
        anotherProvider.trackingDisabled = true
        XCTAssertTrue(sut.trackingDisabled)
    }

    func testTrackingIsEnabledIfSomeProvidersAreEnabled() {
        someProvider.trackingDisabled = false
        anotherProvider.trackingDisabled = true
        XCTAssertFalse(sut.trackingDisabled)
    }

    func testDisableTrackingOnlyIfTagsMatch() {
        sut.disableTracking(true, forTags: [.analytics])
        XCTAssertEqual(someProvider.disableTrackingFlagBoolVoidReceivedInvocations, [])
        XCTAssertEqual(anotherProvider.disableTrackingFlagBoolVoidReceivedInvocations, [true])
    }

    func testEnableTrackingOnlyIfTagsMatch() {
        sut.disableTracking(false, forTags: [.crashReporting])
        XCTAssertEqual(someProvider.disableTrackingFlagBoolVoidReceivedInvocations, [false])
        XCTAssertEqual(anotherProvider.disableTrackingFlagBoolVoidReceivedInvocations, [])
    }
}
