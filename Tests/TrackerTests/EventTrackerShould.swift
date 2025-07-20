import TrackerTesting
import XCTest

@testable import Tracker

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
        someEvent =
            NamedEvent(someEventName)
            + parameters.reduce(
                [],
                { partialResult, value in
                    partialResult + [
                        NamedParameter(key: value.key, value: value.value)
                    ]
                }
            )
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
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEvent.name
        )
        XCTAssertNil(anotherProvider.trackEventEventEventVoidReceivedEvent)
        sut.setServiceProviders([anotherProvider])
        sut.trackEvent(anotherEvent)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEvent.name
        )
        XCTAssertEqual(
            anotherProvider.trackEventEventEventVoidReceivedEvent?.name,
            anotherEvent.name
        )
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
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEventName
        )
        XCTAssertNotEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            anotherEventName
        )
    }

    func testTrackEventsOnlyIfAutoclosureConditionIsMet() {
        sut.trackEvent(someEvent, given: true)
        sut.trackEvent(anotherEvent, given: false)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEventName
        )
        XCTAssertNotEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            anotherEventName
        )
    }

    func testExecuteTrackedEventThenOnlyIfConditionIsMet() {
        var executed = false
        sut.trackEvent(someEvent, given: { true }, then: { executed = true })
        sut.trackEvent(
            anotherEvent,
            given: { false },
            then: {
                XCTFail("must not invoke then when given condition is not met")
            }
        )
        XCTAssertTrue(executed)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEventName
        )
        XCTAssertNotEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            anotherEventName
        )
    }

    func testExecuteTrackedEventThenOnlyIfAutoclosureConditionIsMet() {
        var executed = false
        sut.trackEvent(someEvent, given: true, then: executed = true)
        sut.trackEvent(
            anotherEvent,
            given: false,
            then: XCTFail(
                "must not invoke then when given condition is not met"
            )
        )
        XCTAssertTrue(executed)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEventName
        )
        XCTAssertNotEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            anotherEventName
        )
    }

    func testTrackEventsOnlyIfServiceProviderContainsRequiredTags() {
        sut.trackEvent(debuggingEvent)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            debuggingEventName
        )
        XCTAssertNil(anotherProvider.trackEventEventEventVoidReceivedEvent)
    }

    func testTrackEventsOnlyIfServiceProviderDoesNotContainExcludedTags() {
        sut.trackEvent(nonAnalyticsEvent)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            nonAnalyticsEventName
        )
        XCTAssertNil(anotherProvider.trackEventEventEventVoidReceivedEvent)
    }

    func testTrackEventsWithExpectedName() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEventName
        )
        XCTAssertEqual(
            anotherProvider.trackEventEventEventVoidReceivedEvent?.name,
            someEventName
        )
    }

    func testTrackEventsWithExpectedParameters() {
        sut.trackEvent(someEvent)
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedEvent?
                .resolvedParameters,
            parameters
        )
    }

    func testTrackEventsWithExpectedPropertyKeys() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(
            someProvider.setPropertyKeyStringValueStringVoidReceivedArguments?
                .key,
            somePropertyKey
        )
    }

    func testTrackEventsWithExpectedPropertyValues() {
        sut.setProperty(somePropertyKey, value: somePropertyValue)
        XCTAssertEqual(
            someProvider.setPropertyKeyStringValueStringVoidReceivedArguments?
                .value,
            somePropertyValue
        )
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
        XCTAssertEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            someScreenName
        )
    }

    func testTrackScreenOnlyIfConditionIsMet() {
        sut.trackScreen(someScreen, given: { true })
        sut.trackScreen(anotherScreen, given: { false })
        XCTAssertEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            someScreenName
        )
        XCTAssertNotEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            anotherScreenName
        )
    }

    func testTrackScreenOnlyIfAutoclosureConditionIsMet() {
        sut.trackScreen(someScreen, given: true)
        sut.trackScreen(anotherScreen, given: false)
        XCTAssertEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            someScreenName
        )
        XCTAssertNotEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            anotherScreenName
        )
    }

    func testExecuteTrackedScreenOnlyIfConditionIsMet() {
        var executed = false
        sut.trackScreen(someScreen, given: { true }, then: { executed = true })
        sut.trackScreen(
            anotherScreen,
            given: { false },
            then: {
                XCTFail("must not invoke then when given condition is not met")
            }
        )
        XCTAssertTrue(executed)
        XCTAssertEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            someScreenName
        )
        XCTAssertNotEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            anotherScreenName
        )
    }

    func testExecuteTrackedScreenOnlyIfAutoclosureConditionIsMet() {
        var executed = false
        sut.trackScreen(someScreen, given: true, then: executed = true)
        sut.trackScreen(
            anotherScreen,
            given: false,
            then: XCTFail(
                "must not invoke then when given condition is not met"
            )
        )
        XCTAssertTrue(executed)
        XCTAssertEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            someScreenName
        )
        XCTAssertNotEqual(
            someProvider.trackScreenScreenScreenVoidReceivedScreen?.name,
            anotherScreenName
        )
    }

    func testSetExpectedUserId() {
        sut.setUserId(someUserId)
        XCTAssertEqual(
            someProvider.setUserIdUserIdStringVoidReceivedUserId,
            someUserId
        )
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
        XCTAssertEqual(
            anotherProvider.setUserIdUserIdStringVoidReceivedUserId,
            someUserId
        )
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
        XCTAssertFalse(
            anotherProvider.setPropertyKeyStringValueStringVoidCalled
        )
    }

    func testForwardResetPropertiesToProviders() {
        sut.resetProperties()
        XCTAssertTrue(someProvider.resetPropertiesVoidCalled)
    }

    func testForwardResetPropertiesToProvidersEvenIfTrackingDisabled() {
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
        XCTAssertEqual(
            sut.supportedTags,
            [.crashReporting, .debugging, .analytics]
        )
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
        XCTAssertEqual(
            someProvider.disableTrackingFlagBoolVoidReceivedInvocations,
            []
        )
        XCTAssertEqual(
            anotherProvider.disableTrackingFlagBoolVoidReceivedInvocations,
            [true]
        )
    }

    func testEnableTrackingOnlyIfTagsMatch() {
        sut.disableTracking(false, forTags: [.crashReporting])
        XCTAssertEqual(
            someProvider.disableTrackingFlagBoolVoidReceivedInvocations,
            [false]
        )
        XCTAssertEqual(
            anotherProvider.disableTrackingFlagBoolVoidReceivedInvocations,
            []
        )
    }

    // MARK: - Event with tagged Property Tests

    func testTrackEventWithTaggedProperty() {
        let event =
        NamedEvent("test_event") + [
            TaggedParameter(
                key: "test_key",
                value: "test_value",
                excludedTags: [.debugging],
                requiredTags: [.analytics]
            ),
            NamedParameter(key: "always", value: "true"),
        ]
        sut.trackEvent(event)
        XCTAssertTrue(someProvider.trackEventEventEventVoidCalled)
        XCTAssertTrue(anotherProvider.trackEventEventEventVoidCalled)
        
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedInvocations.first?
                .parameters.count,
            1
        )
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedInvocations.first?
                .parameters.first?.key, "always"
        )
        
        XCTAssertEqual(anotherProvider.trackEventEventEventVoidReceivedInvocations.first?
            .parameters.count, 2)
        XCTAssertEqual(
            anotherProvider.trackEventEventEventVoidReceivedInvocations.first?
                .parameters.first?.key, "test_key"
        )
        XCTAssertEqual(
            anotherProvider.trackEventEventEventVoidReceivedInvocations.first?
                .parameters[1].key, "always"
        )
    }
    
    func testTrackEventWithNonMatchingTaggedProperty() {
        let event =
        NamedEvent("test_event") + [
            TaggedParameter(
                key: "test_key",
                value: "test_value",
                excludedTags: [.appsFlyer],
                requiredTags: [.braze]
            )
        ]
        sut.trackEvent(event)
        XCTAssertTrue(someProvider.trackEventEventEventVoidCalled)
        XCTAssertTrue(anotherProvider.trackEventEventEventVoidCalled)
        
        XCTAssertEqual(
            someProvider.trackEventEventEventVoidReceivedInvocations.first?
                .parameters.count,
            0
        )
        XCTAssertEqual(anotherProvider.trackEventEventEventVoidReceivedInvocations.first?
            .parameters.count, 0)
    }
    

    // MARK: - Property with Tags Tests

    func testForwardPropertyToProvidersWithNoTags() {
        let property = NamedParameter(key: "test_key", value: "test_value")
        sut.setProperty(property)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testForwardPropertyToProvidersWithRequiredTags() {
        let property =
            NamedParameter(key: "test_key", value: "test_value") + [.analytics]
        sut.setProperty(property)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testDoNotForwardPropertyToProvidersWithExcludedTags() {
        let property =
            NamedParameter(key: "test_key", value: "test_value") - [.debugging]
        sut.setProperty(property)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testForwardPropertyWithMultipleRequiredTags() {
        let property =
            NamedParameter(key: "test_key", value: "test_value") + [
                .debugging, .analytics,
            ]
        sut.setProperty(property)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testDoNotForwardPropertyWithMultipleExcludedTags() {
        let property =
            NamedParameter(key: "test_key", value: "test_value") - [
                .debugging, .analytics,
            ]
        sut.setProperty(property)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertFalse(
            anotherProvider.setPropertyKeyStringValueStringVoidCalled
        )
    }

    func testForwardPropertyWithBothRequiredAndExcludedTags() {
        let property =
            NamedParameter(key: "test_key", value: "test_value") + [
                .crashReporting
            ] - [.analytics]
        sut.setProperty(property)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertFalse(
            anotherProvider.setPropertyKeyStringValueStringVoidCalled
        )
    }

    func testDoNotForwardPropertyToDisabledProviders() {
        someProvider.trackingDisabled = true
        let property = NamedParameter(key: "test_key", value: "test_value")
        sut.setProperty(property)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testForwardPropertyWithCondition() {
        let property = NamedParameter(key: "test_key", value: "test_value")
        sut.setProperty(property, given: true)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)

        someProvider.setPropertyKeyStringValueStringVoidCallsCount = 0
        sut.setProperty(property, given: false)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testForwardPropertyToSpecificProvidersWithTags() {
        let property = NamedParameter(key: "test_key", value: "test_value")
        sut.setProperty(property, forTags: [.analytics])
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    // MARK: - Additional Property Filtering Tests

    func testPropertyOperatorChaining() {
        let property = "test_key" + "test_value" + [.analytics] - [.debugging]
        sut.setProperty(property)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testPropertyWithEmptyExcludedTagsButRequiredTags() {
        let property = NamedParameter(key: "test_key", value: "test_value") + [.crashReporting]
        sut.setProperty(property)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertFalse(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testPropertyWithExcludedTagsButEmptyRequiredTags() {
        let property = NamedParameter(key: "test_key", value: "test_value") - [.analytics]
        sut.setProperty(property)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertFalse(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testTaggedParameterInheritance() {
        // Create a parameter with initial tags
        let baseProperty = NamedParameter(key: "test_key", value: "test_value") + [.analytics]
        // Wrap it with additional tags
        let wrappedProperty = TaggedParameter(
            parameter: baseProperty,
            excludedTags: [.debugging],
            requiredTags: []
        )
        sut.setProperty(wrappedProperty)
        // Should not be sent to someProvider (has debugging tag)
        // Should be sent to anotherProvider (has analytics tags)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testPropertyConditionalWithClosure() {
        let property = NamedParameter(key: "test_key", value: "test_value")
        var conditionEvaluated = false
        sut.setProperty(property, given: { 
            conditionEvaluated = true
            return true 
        })
        XCTAssertTrue(conditionEvaluated)
        XCTAssertTrue(someProvider.setPropertyKeyStringValueStringVoidCalled)
        
        someProvider.setPropertyKeyStringValueStringVoidCallsCount = 0
        conditionEvaluated = false
        sut.setProperty(property, given: { 
            conditionEvaluated = true
            return false 
        })
        XCTAssertTrue(conditionEvaluated)
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
    }

    func testEventWithMixedParameterTypes() {
        let event = NamedEvent("test_event") + [
            NamedParameter(key: "always_included", value: "yes"),
            TaggedParameter(
                key: "analytics_only",
                value: "data",
                excludedTags: [],
                requiredTags: [.analytics]
            ),
            TaggedParameter(
                key: "no_debugging",
                value: "sensitive",
                excludedTags: [.debugging],
                requiredTags: []
            )
        ]
        sut.trackEvent(event)
        
        let someProviderParams = someProvider.trackEventEventEventVoidReceivedInvocations.first?.parameters
        XCTAssertEqual(someProviderParams?.count, 1)
        XCTAssertTrue(someProviderParams?.contains { $0.key == "always_included" } ?? false)
        XCTAssertFalse(someProviderParams?.contains { $0.key == "analytics_only" } ?? true)
        XCTAssertFalse(someProviderParams?.contains { $0.key == "no_debugging" } ?? true)
        
        let anotherProviderParams = anotherProvider.trackEventEventEventVoidReceivedInvocations.first?.parameters
        XCTAssertEqual(anotherProviderParams?.count, 3)
        XCTAssertTrue(anotherProviderParams?.contains { $0.key == "always_included" } ?? false)
        XCTAssertTrue(anotherProviderParams?.contains { $0.key == "analytics_only" } ?? false)
        XCTAssertTrue(anotherProviderParams?.contains { $0.key == "no_debugging" } ?? false)
    }

    func testPropertyWithForTagsCombinesFiltering() {
        // Property requires analytics, but we're sending it only to debugging providers
        let property = NamedParameter(key: "test_key", value: "test_value") + [.analytics]
        sut.setProperty(property, forTags: [.debugging])
        // someProvider has debugging tag but property requires analytics - should not receive
        XCTAssertFalse(someProvider.setPropertyKeyStringValueStringVoidCalled)
        // anotherProvider has analytics tag but we're targeting debugging - should not receive
        XCTAssertFalse(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
        
        // Now send to analytics providers
        sut.setProperty(property, forTags: [.analytics])
        // anotherProvider has analytics tag and property requires analytics - should receive
        XCTAssertTrue(anotherProvider.setPropertyKeyStringValueStringVoidCalled)
    }
}
