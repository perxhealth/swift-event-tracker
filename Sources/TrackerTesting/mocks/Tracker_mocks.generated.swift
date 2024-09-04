// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: ./Scripts/generate_mocks.sh --target=Tracker --output=./Sources/TrackerTesting/mocks/Tracker_mocks.generated.swift

 @testable import Tracker

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class AdjustServiceAdapterMock: AdjustServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - trackEvent
        trackEventEventNameStringParametersStringStringVoidCallsCount = 0
        trackEventEventNameStringParametersStringStringVoidReceivedArguments = nil
        trackEventEventNameStringParametersStringStringVoidReceivedInvocations = []
        trackEventEventNameStringParametersStringStringVoidClosure = nil


         //MARK: - setEnabled
        setEnabledFlagBoolVoidCallsCount = 0
        setEnabledFlagBoolVoidReceivedFlag = nil
        setEnabledFlagBoolVoidReceivedInvocations = []
        setEnabledFlagBoolVoidClosure = nil


    }

    //MARK: - trackEvent

    public static var trackEventEventNameStringParametersStringStringVoidCallsCount = 0
    public static var trackEventEventNameStringParametersStringStringVoidCalled: Bool {
        return trackEventEventNameStringParametersStringStringVoidCallsCount > 0
    }
    public static var trackEventEventNameStringParametersStringStringVoidReceivedArguments: (eventName: String, parameters: [String: String])?
    public static var trackEventEventNameStringParametersStringStringVoidReceivedInvocations: [(eventName: String, parameters: [String: String])] = []
    public static var trackEventEventNameStringParametersStringStringVoidClosure: ((String, [String: String]) -> Void)?

    public static func trackEvent(_ eventName: String, parameters: [String: String]) {
        trackEventEventNameStringParametersStringStringVoidCallsCount += 1
        trackEventEventNameStringParametersStringStringVoidReceivedArguments = (eventName: eventName, parameters: parameters)
        trackEventEventNameStringParametersStringStringVoidReceivedInvocations.append((eventName: eventName, parameters: parameters))
        trackEventEventNameStringParametersStringStringVoidClosure?(eventName, parameters)
    }

    //MARK: - setEnabled

    public static var setEnabledFlagBoolVoidCallsCount = 0
    public static var setEnabledFlagBoolVoidCalled: Bool {
        return setEnabledFlagBoolVoidCallsCount > 0
    }
    public static var setEnabledFlagBoolVoidReceivedFlag: (Bool)?
    public static var setEnabledFlagBoolVoidReceivedInvocations: [(Bool)] = []
    public static var setEnabledFlagBoolVoidClosure: ((Bool) -> Void)?

    public static func setEnabled(_ flag: Bool) {
        setEnabledFlagBoolVoidCallsCount += 1
        setEnabledFlagBoolVoidReceivedFlag = flag
        setEnabledFlagBoolVoidReceivedInvocations.append(flag)
        setEnabledFlagBoolVoidClosure?(flag)
    }


}
public class AmplitudeServiceAdapterMock: AmplitudeServiceAdapter {

    public init() {}

    public var optOut: Bool {
        get { return underlyingOptOut }
        set(value) { underlyingOptOut = value }
    }
    public var underlyingOptOut: (Bool)!


    //MARK: - clearUserProperties

    public var clearUserPropertiesVoidCallsCount = 0
    public var clearUserPropertiesVoidCalled: Bool {
        return clearUserPropertiesVoidCallsCount > 0
    }
    public var clearUserPropertiesVoidClosure: (() -> Void)?

    public func clearUserProperties() {
        clearUserPropertiesVoidCallsCount += 1
        clearUserPropertiesVoidClosure?()
    }

    //MARK: - logEvent

    public var logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidCallsCount = 0
    public var logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidCalled: Bool {
        return logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidCallsCount > 0
    }
    public var logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedArguments: (eventType: String, withEventProperties: [AnyHashable: Any]?)?
    public var logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedInvocations: [(eventType: String, withEventProperties: [AnyHashable: Any]?)] = []
    public var logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidClosure: ((String, [AnyHashable: Any]?) -> Void)?

    public func logEvent(_ eventType: String, withEventProperties: [AnyHashable: Any]?) {
        logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidCallsCount += 1
        logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedArguments = (eventType: eventType, withEventProperties: withEventProperties)
        logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidReceivedInvocations.append((eventType: eventType, withEventProperties: withEventProperties))
        logEventEventTypeStringWithEventPropertiesAnyHashableAnyVoidClosure?(eventType, withEventProperties)
    }

    //MARK: - regenerateDeviceId

    public var regenerateDeviceIdVoidCallsCount = 0
    public var regenerateDeviceIdVoidCalled: Bool {
        return regenerateDeviceIdVoidCallsCount > 0
    }
    public var regenerateDeviceIdVoidClosure: (() -> Void)?

    public func regenerateDeviceId() {
        regenerateDeviceIdVoidCallsCount += 1
        regenerateDeviceIdVoidClosure?()
    }

    //MARK: - setUserId

    public var setUserIdIdStringVoidCallsCount = 0
    public var setUserIdIdStringVoidCalled: Bool {
        return setUserIdIdStringVoidCallsCount > 0
    }
    public var setUserIdIdStringVoidReceivedId: (String)?
    public var setUserIdIdStringVoidReceivedInvocations: [(String)?] = []
    public var setUserIdIdStringVoidClosure: ((String?) -> Void)?

    public func setUserId(_ id: String?) {
        setUserIdIdStringVoidCallsCount += 1
        setUserIdIdStringVoidReceivedId = id
        setUserIdIdStringVoidReceivedInvocations.append(id)
        setUserIdIdStringVoidClosure?(id)
    }

    //MARK: - setUserProperties

    public var setUserPropertiesDictionaryAnyHashableAnyVoidCallsCount = 0
    public var setUserPropertiesDictionaryAnyHashableAnyVoidCalled: Bool {
        return setUserPropertiesDictionaryAnyHashableAnyVoidCallsCount > 0
    }
    public var setUserPropertiesDictionaryAnyHashableAnyVoidReceivedDictionary: ([AnyHashable: Any])?
    public var setUserPropertiesDictionaryAnyHashableAnyVoidReceivedInvocations: [([AnyHashable: Any])] = []
    public var setUserPropertiesDictionaryAnyHashableAnyVoidClosure: (([AnyHashable: Any]) -> Void)?

    public func setUserProperties(_ dictionary: [AnyHashable: Any]) {
        setUserPropertiesDictionaryAnyHashableAnyVoidCallsCount += 1
        setUserPropertiesDictionaryAnyHashableAnyVoidReceivedDictionary = dictionary
        setUserPropertiesDictionaryAnyHashableAnyVoidReceivedInvocations.append(dictionary)
        setUserPropertiesDictionaryAnyHashableAnyVoidClosure?(dictionary)
    }


}
public class AppCenterAnalyticsServiceAdapterMock: AppCenterAnalyticsServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - pause
        pauseVoidCallsCount = 0
        pauseVoidClosure = nil


         //MARK: - resume
        resumeVoidCallsCount = 0
        resumeVoidClosure = nil


         //MARK: - trackEvent
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCallsCount = 0
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments = nil
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedInvocations = []
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidClosure = nil


    }

    //MARK: - pause

    public static var pauseVoidCallsCount = 0
    public static var pauseVoidCalled: Bool {
        return pauseVoidCallsCount > 0
    }
    public static var pauseVoidClosure: (() -> Void)?

    public static func pause() {
        pauseVoidCallsCount += 1
        pauseVoidClosure?()
    }

    //MARK: - resume

    public static var resumeVoidCallsCount = 0
    public static var resumeVoidCalled: Bool {
        return resumeVoidCallsCount > 0
    }
    public static var resumeVoidClosure: (() -> Void)?

    public static func resume() {
        resumeVoidCallsCount += 1
        resumeVoidClosure?()
    }

    //MARK: - trackEvent

    public static var trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCallsCount = 0
    public static var trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCalled: Bool {
        return trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCallsCount > 0
    }
    public static var trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments: (eventName: String, properties: [String: String]?)?
    public static var trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedInvocations: [(eventName: String, properties: [String: String]?)] = []
    public static var trackEventEventNameStringWithPropertiesPropertiesStringStringVoidClosure: ((String, [String: String]?) -> Void)?

    public static func trackEvent(_ eventName: String, withProperties properties: [String: String]?) {
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidCallsCount += 1
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedArguments = (eventName: eventName, properties: properties)
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidReceivedInvocations.append((eventName: eventName, properties: properties))
        trackEventEventNameStringWithPropertiesPropertiesStringStringVoidClosure?(eventName, properties)
    }


}
public class AppsFlyerServiceAdapterMock: AppsFlyerServiceAdapter {

    public init() {}

    public var customData: [AnyHashable: Any]?
    public var customerUserID: String?
    public var isStopped: Bool {
        get { return underlyingIsStopped }
        set(value) { underlyingIsStopped = value }
    }
    public var underlyingIsStopped: (Bool)!


    //MARK: - logEvent

    public var logEventEventNameStringWithValuesAnyHashableAnyVoidCallsCount = 0
    public var logEventEventNameStringWithValuesAnyHashableAnyVoidCalled: Bool {
        return logEventEventNameStringWithValuesAnyHashableAnyVoidCallsCount > 0
    }
    public var logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedArguments: (eventName: String, withValues: [AnyHashable: Any]?)?
    public var logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedInvocations: [(eventName: String, withValues: [AnyHashable: Any]?)] = []
    public var logEventEventNameStringWithValuesAnyHashableAnyVoidClosure: ((String, [AnyHashable: Any]?) -> Void)?

    public func logEvent(_ eventName: String, withValues: [AnyHashable: Any]?) {
        logEventEventNameStringWithValuesAnyHashableAnyVoidCallsCount += 1
        logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedArguments = (eventName: eventName, withValues: withValues)
        logEventEventNameStringWithValuesAnyHashableAnyVoidReceivedInvocations.append((eventName: eventName, withValues: withValues))
        logEventEventNameStringWithValuesAnyHashableAnyVoidClosure?(eventName, withValues)
    }


}
public class BrazeServiceAdapterMock: BrazeServiceAdapter {

    public init() {}



    //MARK: - changeUser

    public var changeUserUserIdStringVoidCallsCount = 0
    public var changeUserUserIdStringVoidCalled: Bool {
        return changeUserUserIdStringVoidCallsCount > 0
    }
    public var changeUserUserIdStringVoidReceivedUserId: (String)?
    public var changeUserUserIdStringVoidReceivedInvocations: [(String)] = []
    public var changeUserUserIdStringVoidClosure: ((String) -> Void)?

    public func changeUser(_ userId: String) {
        changeUserUserIdStringVoidCallsCount += 1
        changeUserUserIdStringVoidReceivedUserId = userId
        changeUserUserIdStringVoidReceivedInvocations.append(userId)
        changeUserUserIdStringVoidClosure?(userId)
    }

    //MARK: - logCustomEvent

    public var logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidCallsCount = 0
    public var logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidCalled: Bool {
        return logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidCallsCount > 0
    }
    public var logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedArguments: (eventName: String, withProperties: [AnyHashable: Any]?)?
    public var logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedInvocations: [(eventName: String, withProperties: [AnyHashable: Any]?)] = []
    public var logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidClosure: ((String, [AnyHashable: Any]?) -> Void)?

    public func logCustomEvent(_ eventName: String, withProperties: [AnyHashable: Any]?) {
        logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidCallsCount += 1
        logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedArguments = (eventName: eventName, withProperties: withProperties)
        logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidReceivedInvocations.append((eventName: eventName, withProperties: withProperties))
        logCustomEventEventNameStringWithPropertiesAnyHashableAnyVoidClosure?(eventName, withProperties)
    }

    //MARK: - setCustomAttributeWithKey

    public var setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidCallsCount = 0
    public var setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidCalled: Bool {
        return setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidCallsCount > 0
    }
    public var setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidReceivedArguments: (key: String, value: String)?
    public var setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidReceivedInvocations: [(key: String, value: String)] = []
    public var setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidClosure: ((String, String) -> Void)?

    public func setCustomAttributeWithKey(_ key: String, andStringValue value: String) {
        setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidCallsCount += 1
        setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidReceivedArguments = (key: key, value: value)
        setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidReceivedInvocations.append((key: key, value: value))
        setCustomAttributeWithKeyKeyStringAndStringValueValueStringVoidClosure?(key, value)
    }

    //MARK: - unsetCustomAttributeWithKey

    public var unsetCustomAttributeWithKeyKeyStringVoidCallsCount = 0
    public var unsetCustomAttributeWithKeyKeyStringVoidCalled: Bool {
        return unsetCustomAttributeWithKeyKeyStringVoidCallsCount > 0
    }
    public var unsetCustomAttributeWithKeyKeyStringVoidReceivedKey: (String)?
    public var unsetCustomAttributeWithKeyKeyStringVoidReceivedInvocations: [(String)] = []
    public var unsetCustomAttributeWithKeyKeyStringVoidClosure: ((String) -> Void)?

    public func unsetCustomAttributeWithKey(_ key: String) {
        unsetCustomAttributeWithKeyKeyStringVoidCallsCount += 1
        unsetCustomAttributeWithKeyKeyStringVoidReceivedKey = key
        unsetCustomAttributeWithKeyKeyStringVoidReceivedInvocations.append(key)
        unsetCustomAttributeWithKeyKeyStringVoidClosure?(key)
    }


}
public class BugseeServiceAdapterMock: BugseeServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - clearAllAttribute
        clearAllAttributeBoolCallsCount = 0
        clearAllAttributeBoolClosure = nil


         //MARK: - event
        eventEventNameStringParamsAnyHashableAnyVoidCallsCount = 0
        eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments = nil
        eventEventNameStringParamsAnyHashableAnyVoidReceivedInvocations = []
        eventEventNameStringParamsAnyHashableAnyVoidClosure = nil


         //MARK: - pause
        pauseVoidCallsCount = 0
        pauseVoidClosure = nil


         //MARK: - resume
        resumeVoidCallsCount = 0
        resumeVoidClosure = nil


         //MARK: - setAttribute
        setAttributeKeyStringValueAnyBoolCallsCount = 0
        setAttributeKeyStringValueAnyBoolReceivedArguments = nil
        setAttributeKeyStringValueAnyBoolReceivedInvocations = []
        setAttributeKeyStringValueAnyBoolClosure = nil


    }

    //MARK: - clearAllAttribute

    public static var clearAllAttributeBoolCallsCount = 0
    public static var clearAllAttributeBoolCalled: Bool {
        return clearAllAttributeBoolCallsCount > 0
    }
    public static var clearAllAttributeBoolReturnValue: Bool!
    public static var clearAllAttributeBoolClosure: (() -> Bool)?

    public static func clearAllAttribute() -> Bool {
        clearAllAttributeBoolCallsCount += 1
        if let clearAllAttributeBoolClosure = clearAllAttributeBoolClosure {
            return clearAllAttributeBoolClosure()
        } else {
            return clearAllAttributeBoolReturnValue
        }
    }

    //MARK: - event

    public static var eventEventNameStringParamsAnyHashableAnyVoidCallsCount = 0
    public static var eventEventNameStringParamsAnyHashableAnyVoidCalled: Bool {
        return eventEventNameStringParamsAnyHashableAnyVoidCallsCount > 0
    }
    public static var eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments: (eventName: String, params: [AnyHashable: Any])?
    public static var eventEventNameStringParamsAnyHashableAnyVoidReceivedInvocations: [(eventName: String, params: [AnyHashable: Any])] = []
    public static var eventEventNameStringParamsAnyHashableAnyVoidClosure: ((String, [AnyHashable: Any]) -> Void)?

    public static func event(_ eventName: String, params: [AnyHashable: Any]) {
        eventEventNameStringParamsAnyHashableAnyVoidCallsCount += 1
        eventEventNameStringParamsAnyHashableAnyVoidReceivedArguments = (eventName: eventName, params: params)
        eventEventNameStringParamsAnyHashableAnyVoidReceivedInvocations.append((eventName: eventName, params: params))
        eventEventNameStringParamsAnyHashableAnyVoidClosure?(eventName, params)
    }

    //MARK: - pause

    public static var pauseVoidCallsCount = 0
    public static var pauseVoidCalled: Bool {
        return pauseVoidCallsCount > 0
    }
    public static var pauseVoidClosure: (() -> Void)?

    public static func pause() {
        pauseVoidCallsCount += 1
        pauseVoidClosure?()
    }

    //MARK: - resume

    public static var resumeVoidCallsCount = 0
    public static var resumeVoidCalled: Bool {
        return resumeVoidCallsCount > 0
    }
    public static var resumeVoidClosure: (() -> Void)?

    public static func resume() {
        resumeVoidCallsCount += 1
        resumeVoidClosure?()
    }

    //MARK: - setAttribute

    public static var setAttributeKeyStringValueAnyBoolCallsCount = 0
    public static var setAttributeKeyStringValueAnyBoolCalled: Bool {
        return setAttributeKeyStringValueAnyBoolCallsCount > 0
    }
    public static var setAttributeKeyStringValueAnyBoolReceivedArguments: (key: String, value: Any)?
    public static var setAttributeKeyStringValueAnyBoolReceivedInvocations: [(key: String, value: Any)] = []
    public static var setAttributeKeyStringValueAnyBoolReturnValue: Bool!
    public static var setAttributeKeyStringValueAnyBoolClosure: ((String, Any) -> Bool)?

    public static func setAttribute(_ key: String, value: Any) -> Bool {
        setAttributeKeyStringValueAnyBoolCallsCount += 1
        setAttributeKeyStringValueAnyBoolReceivedArguments = (key: key, value: value)
        setAttributeKeyStringValueAnyBoolReceivedInvocations.append((key: key, value: value))
        if let setAttributeKeyStringValueAnyBoolClosure = setAttributeKeyStringValueAnyBoolClosure {
            return setAttributeKeyStringValueAnyBoolClosure(key, value)
        } else {
            return setAttributeKeyStringValueAnyBoolReturnValue
        }
    }


}
public class CountlyScreenMock: CountlyScreen {

    public init() {}

    public var segmentation: [String: String] = [:]
    public var name: String {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }
    public var underlyingName: (String)!
    public var excludedTags: [Tag] = []
    public var requiredTags: [Tag] = []



}
public class CountlyServiceAdapterMock: CountlyServiceAdapter {

    public init() {}



    //MARK: - recordEvent

    public var recordEventEventNameStringSegmentationStringAnyVoidCallsCount = 0
    public var recordEventEventNameStringSegmentationStringAnyVoidCalled: Bool {
        return recordEventEventNameStringSegmentationStringAnyVoidCallsCount > 0
    }
    public var recordEventEventNameStringSegmentationStringAnyVoidReceivedArguments: (eventName: String, segmentation: [String: Any]?)?
    public var recordEventEventNameStringSegmentationStringAnyVoidReceivedInvocations: [(eventName: String, segmentation: [String: Any]?)] = []
    public var recordEventEventNameStringSegmentationStringAnyVoidClosure: ((String, [String: Any]?) -> Void)?

    public func recordEvent(_ eventName: String, segmentation: [String: Any]?) {
        recordEventEventNameStringSegmentationStringAnyVoidCallsCount += 1
        recordEventEventNameStringSegmentationStringAnyVoidReceivedArguments = (eventName: eventName, segmentation: segmentation)
        recordEventEventNameStringSegmentationStringAnyVoidReceivedInvocations.append((eventName: eventName, segmentation: segmentation))
        recordEventEventNameStringSegmentationStringAnyVoidClosure?(eventName, segmentation)
    }

    //MARK: - recordView

    public var recordViewViewStringVoidCallsCount = 0
    public var recordViewViewStringVoidCalled: Bool {
        return recordViewViewStringVoidCallsCount > 0
    }
    public var recordViewViewStringVoidReceivedView: (String)?
    public var recordViewViewStringVoidReceivedInvocations: [(String)] = []
    public var recordViewViewStringVoidClosure: ((String) -> Void)?

    public func recordView(_ view: String) {
        recordViewViewStringVoidCallsCount += 1
        recordViewViewStringVoidReceivedView = view
        recordViewViewStringVoidReceivedInvocations.append(view)
        recordViewViewStringVoidClosure?(view)
    }

    //MARK: - recordView

    public var recordViewViewStringSegmentationStringAnyVoidCallsCount = 0
    public var recordViewViewStringSegmentationStringAnyVoidCalled: Bool {
        return recordViewViewStringSegmentationStringAnyVoidCallsCount > 0
    }
    public var recordViewViewStringSegmentationStringAnyVoidReceivedArguments: (view: String, segmentation: [String: Any])?
    public var recordViewViewStringSegmentationStringAnyVoidReceivedInvocations: [(view: String, segmentation: [String: Any])] = []
    public var recordViewViewStringSegmentationStringAnyVoidClosure: ((String, [String: Any]) -> Void)?

    public func recordView(_ view: String, segmentation: [String: Any]) {
        recordViewViewStringSegmentationStringAnyVoidCallsCount += 1
        recordViewViewStringSegmentationStringAnyVoidReceivedArguments = (view: view, segmentation: segmentation)
        recordViewViewStringSegmentationStringAnyVoidReceivedInvocations.append((view: view, segmentation: segmentation))
        recordViewViewStringSegmentationStringAnyVoidClosure?(view, segmentation)
    }

    //MARK: - userLogged

    public var userLoggedInUserIDStringVoidCallsCount = 0
    public var userLoggedInUserIDStringVoidCalled: Bool {
        return userLoggedInUserIDStringVoidCallsCount > 0
    }
    public var userLoggedInUserIDStringVoidReceivedUserID: (String)?
    public var userLoggedInUserIDStringVoidReceivedInvocations: [(String)] = []
    public var userLoggedInUserIDStringVoidClosure: ((String) -> Void)?

    public func userLogged(in userID: String) {
        userLoggedInUserIDStringVoidCallsCount += 1
        userLoggedInUserIDStringVoidReceivedUserID = userID
        userLoggedInUserIDStringVoidReceivedInvocations.append(userID)
        userLoggedInUserIDStringVoidClosure?(userID)
    }

    //MARK: - userLoggedOut

    public var userLoggedOutVoidCallsCount = 0
    public var userLoggedOutVoidCalled: Bool {
        return userLoggedOutVoidCallsCount > 0
    }
    public var userLoggedOutVoidClosure: (() -> Void)?

    public func userLoggedOut() {
        userLoggedOutVoidCallsCount += 1
        userLoggedOutVoidClosure?()
    }

    //MARK: - giveConsentForAllFeatures

    public var giveConsentForAllFeaturesVoidCallsCount = 0
    public var giveConsentForAllFeaturesVoidCalled: Bool {
        return giveConsentForAllFeaturesVoidCallsCount > 0
    }
    public var giveConsentForAllFeaturesVoidClosure: (() -> Void)?

    public func giveConsentForAllFeatures() {
        giveConsentForAllFeaturesVoidCallsCount += 1
        giveConsentForAllFeaturesVoidClosure?()
    }

    //MARK: - cancelConsentForAllFeatures

    public var cancelConsentForAllFeaturesVoidCallsCount = 0
    public var cancelConsentForAllFeaturesVoidCalled: Bool {
        return cancelConsentForAllFeaturesVoidCallsCount > 0
    }
    public var cancelConsentForAllFeaturesVoidClosure: (() -> Void)?

    public func cancelConsentForAllFeatures() {
        cancelConsentForAllFeaturesVoidCallsCount += 1
        cancelConsentForAllFeaturesVoidClosure?()
    }


}
public class CountlyUserDetailsAdapterMock: CountlyUserDetailsAdapter {

    public init() {}



    //MARK: - set

    public var setKeyStringValueStringVoidCallsCount = 0
    public var setKeyStringValueStringVoidCalled: Bool {
        return setKeyStringValueStringVoidCallsCount > 0
    }
    public var setKeyStringValueStringVoidReceivedArguments: (key: String, value: String)?
    public var setKeyStringValueStringVoidReceivedInvocations: [(key: String, value: String)] = []
    public var setKeyStringValueStringVoidClosure: ((String, String) -> Void)?

    public func set(_ key: String, value: String) {
        setKeyStringValueStringVoidCallsCount += 1
        setKeyStringValueStringVoidReceivedArguments = (key: key, value: value)
        setKeyStringValueStringVoidReceivedInvocations.append((key: key, value: value))
        setKeyStringValueStringVoidClosure?(key, value)
    }

    //MARK: - unSet

    public var unSetKeyStringVoidCallsCount = 0
    public var unSetKeyStringVoidCalled: Bool {
        return unSetKeyStringVoidCallsCount > 0
    }
    public var unSetKeyStringVoidReceivedKey: (String)?
    public var unSetKeyStringVoidReceivedInvocations: [(String)] = []
    public var unSetKeyStringVoidClosure: ((String) -> Void)?

    public func unSet(_ key: String) {
        unSetKeyStringVoidCallsCount += 1
        unSetKeyStringVoidReceivedKey = key
        unSetKeyStringVoidReceivedInvocations.append(key)
        unSetKeyStringVoidClosure?(key)
    }


}
public class CrashlyticsServiceAdapterMock: CrashlyticsServiceAdapter {

    public init() {}



    //MARK: - deleteUnsentReports

    public var deleteUnsentReportsVoidCallsCount = 0
    public var deleteUnsentReportsVoidCalled: Bool {
        return deleteUnsentReportsVoidCallsCount > 0
    }
    public var deleteUnsentReportsVoidClosure: (() -> Void)?

    public func deleteUnsentReports() {
        deleteUnsentReportsVoidCallsCount += 1
        deleteUnsentReportsVoidClosure?()
    }

    //MARK: - log

    public var logMsgStringVoidCallsCount = 0
    public var logMsgStringVoidCalled: Bool {
        return logMsgStringVoidCallsCount > 0
    }
    public var logMsgStringVoidReceivedMsg: (String)?
    public var logMsgStringVoidReceivedInvocations: [(String)] = []
    public var logMsgStringVoidClosure: ((String) -> Void)?

    public func log(_ msg: String) {
        logMsgStringVoidCallsCount += 1
        logMsgStringVoidReceivedMsg = msg
        logMsgStringVoidReceivedInvocations.append(msg)
        logMsgStringVoidClosure?(msg)
    }

    //MARK: - record

    public var recordErrorSwiftErrorVoidCallsCount = 0
    public var recordErrorSwiftErrorVoidCalled: Bool {
        return recordErrorSwiftErrorVoidCallsCount > 0
    }
    public var recordErrorSwiftErrorVoidReceivedError: (Swift.Error)?
    public var recordErrorSwiftErrorVoidReceivedInvocations: [(Swift.Error)] = []
    public var recordErrorSwiftErrorVoidClosure: ((Swift.Error) -> Void)?

    public func record(error: Swift.Error) {
        recordErrorSwiftErrorVoidCallsCount += 1
        recordErrorSwiftErrorVoidReceivedError = error
        recordErrorSwiftErrorVoidReceivedInvocations.append(error)
        recordErrorSwiftErrorVoidClosure?(error)
    }

    //MARK: - setCrashlyticsCollectionEnabled

    public var setCrashlyticsCollectionEnabledFlagBoolVoidCallsCount = 0
    public var setCrashlyticsCollectionEnabledFlagBoolVoidCalled: Bool {
        return setCrashlyticsCollectionEnabledFlagBoolVoidCallsCount > 0
    }
    public var setCrashlyticsCollectionEnabledFlagBoolVoidReceivedFlag: (Bool)?
    public var setCrashlyticsCollectionEnabledFlagBoolVoidReceivedInvocations: [(Bool)] = []
    public var setCrashlyticsCollectionEnabledFlagBoolVoidClosure: ((Bool) -> Void)?

    public func setCrashlyticsCollectionEnabled(_ flag: Bool) {
        setCrashlyticsCollectionEnabledFlagBoolVoidCallsCount += 1
        setCrashlyticsCollectionEnabledFlagBoolVoidReceivedFlag = flag
        setCrashlyticsCollectionEnabledFlagBoolVoidReceivedInvocations.append(flag)
        setCrashlyticsCollectionEnabledFlagBoolVoidClosure?(flag)
    }

    //MARK: - isCrashlyticsCollectionEnabled

    public var isCrashlyticsCollectionEnabledBoolCallsCount = 0
    public var isCrashlyticsCollectionEnabledBoolCalled: Bool {
        return isCrashlyticsCollectionEnabledBoolCallsCount > 0
    }
    public var isCrashlyticsCollectionEnabledBoolReturnValue: Bool!
    public var isCrashlyticsCollectionEnabledBoolClosure: (() -> Bool)?

    public func isCrashlyticsCollectionEnabled() -> Bool {
        isCrashlyticsCollectionEnabledBoolCallsCount += 1
        if let isCrashlyticsCollectionEnabledBoolClosure = isCrashlyticsCollectionEnabledBoolClosure {
            return isCrashlyticsCollectionEnabledBoolClosure()
        } else {
            return isCrashlyticsCollectionEnabledBoolReturnValue
        }
    }

    //MARK: - setCustomValue

    public var setCustomValueValueAnyForKeyStringVoidCallsCount = 0
    public var setCustomValueValueAnyForKeyStringVoidCalled: Bool {
        return setCustomValueValueAnyForKeyStringVoidCallsCount > 0
    }
    public var setCustomValueValueAnyForKeyStringVoidReceivedArguments: (value: Any?, forKey: String)?
    public var setCustomValueValueAnyForKeyStringVoidReceivedInvocations: [(value: Any?, forKey: String)] = []
    public var setCustomValueValueAnyForKeyStringVoidClosure: ((Any?, String) -> Void)?

    public func setCustomValue(_ value: Any?, forKey: String) {
        setCustomValueValueAnyForKeyStringVoidCallsCount += 1
        setCustomValueValueAnyForKeyStringVoidReceivedArguments = (value: value, forKey: forKey)
        setCustomValueValueAnyForKeyStringVoidReceivedInvocations.append((value: value, forKey: forKey))
        setCustomValueValueAnyForKeyStringVoidClosure?(value, forKey)
    }

    //MARK: - setUserID

    public var setUserIDUserIdStringVoidCallsCount = 0
    public var setUserIDUserIdStringVoidCalled: Bool {
        return setUserIDUserIdStringVoidCallsCount > 0
    }
    public var setUserIDUserIdStringVoidReceivedUserId: (String)?
    public var setUserIDUserIdStringVoidReceivedInvocations: [(String)?] = []
    public var setUserIDUserIdStringVoidClosure: ((String?) -> Void)?

    public func setUserID(_ userId: String?) {
        setUserIDUserIdStringVoidCallsCount += 1
        setUserIDUserIdStringVoidReceivedUserId = userId
        setUserIDUserIdStringVoidReceivedInvocations.append(userId)
        setUserIDUserIdStringVoidClosure?(userId)
    }


}
public class EventMock: Event {

    public init() {}

    public var name: String {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }
    public var underlyingName: (String)!
    public var parameters: [String: String] = [:]
    public var excludedTags: [Tag] = []
    public var requiredTags: [Tag] = []



}
public class FacebookServiceAdapterMock: FacebookServiceAdapter {

    public init() {}

    public var userID: String?


    //MARK: - clearUserID

    public var clearUserIDVoidCallsCount = 0
    public var clearUserIDVoidCalled: Bool {
        return clearUserIDVoidCallsCount > 0
    }
    public var clearUserIDVoidClosure: (() -> Void)?

    public func clearUserID() {
        clearUserIDVoidCallsCount += 1
        clearUserIDVoidClosure?()
    }

    //MARK: - logEvent

    public var logEventEventNameStringParametersStringAnyVoidCallsCount = 0
    public var logEventEventNameStringParametersStringAnyVoidCalled: Bool {
        return logEventEventNameStringParametersStringAnyVoidCallsCount > 0
    }
    public var logEventEventNameStringParametersStringAnyVoidReceivedArguments: (eventName: String, parameters: [String : Any])?
    public var logEventEventNameStringParametersStringAnyVoidReceivedInvocations: [(eventName: String, parameters: [String : Any])] = []
    public var logEventEventNameStringParametersStringAnyVoidClosure: ((String, [String : Any]) -> Void)?

    public func logEvent(_ eventName: String, parameters: [String : Any]) {
        logEventEventNameStringParametersStringAnyVoidCallsCount += 1
        logEventEventNameStringParametersStringAnyVoidReceivedArguments = (eventName: eventName, parameters: parameters)
        logEventEventNameStringParametersStringAnyVoidReceivedInvocations.append((eventName: eventName, parameters: parameters))
        logEventEventNameStringParametersStringAnyVoidClosure?(eventName, parameters)
    }


}
public class FacebookSettingsAdapterMock: FacebookSettingsAdapter {

    public init() {}

    public var isAutoLogAppEventsEnabled: Bool {
        get { return underlyingIsAutoLogAppEventsEnabled }
        set(value) { underlyingIsAutoLogAppEventsEnabled = value }
    }
    public var underlyingIsAutoLogAppEventsEnabled: (Bool)!



}
public class FirebaseAnalyticsScreenMock: FirebaseAnalyticsScreen {

    public init() {}

    public var screenClass: String {
        get { return underlyingScreenClass }
        set(value) { underlyingScreenClass = value }
    }
    public var underlyingScreenClass: (String)!
    public var name: String {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }
    public var underlyingName: (String)!
    public var excludedTags: [Tag] = []
    public var requiredTags: [Tag] = []



}
public class FirebaseAnalyticsServiceAdapterMock: FirebaseAnalyticsServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - logEvent
        logEventNameStringParametersStringAnyVoidCallsCount = 0
        logEventNameStringParametersStringAnyVoidReceivedArguments = nil
        logEventNameStringParametersStringAnyVoidReceivedInvocations = []
        logEventNameStringParametersStringAnyVoidClosure = nil


         //MARK: - setAnalyticsCollectionEnabled
        setAnalyticsCollectionEnabledEnabledBoolVoidCallsCount = 0
        setAnalyticsCollectionEnabledEnabledBoolVoidReceivedEnabled = nil
        setAnalyticsCollectionEnabledEnabledBoolVoidReceivedInvocations = []
        setAnalyticsCollectionEnabledEnabledBoolVoidClosure = nil


         //MARK: - setUserID
        setUserIDUserIdStringVoidCallsCount = 0
        setUserIDUserIdStringVoidReceivedUserId = nil
        setUserIDUserIdStringVoidReceivedInvocations = []
        setUserIDUserIdStringVoidClosure = nil


         //MARK: - setUserProperty
        setUserPropertyValueStringForNameStringVoidCallsCount = 0
        setUserPropertyValueStringForNameStringVoidReceivedArguments = nil
        setUserPropertyValueStringForNameStringVoidReceivedInvocations = []
        setUserPropertyValueStringForNameStringVoidClosure = nil


    }

    //MARK: - logEvent

    public static var logEventNameStringParametersStringAnyVoidCallsCount = 0
    public static var logEventNameStringParametersStringAnyVoidCalled: Bool {
        return logEventNameStringParametersStringAnyVoidCallsCount > 0
    }
    public static var logEventNameStringParametersStringAnyVoidReceivedArguments: (name: String, parameters: [String: Any]?)?
    public static var logEventNameStringParametersStringAnyVoidReceivedInvocations: [(name: String, parameters: [String: Any]?)] = []
    public static var logEventNameStringParametersStringAnyVoidClosure: ((String, [String: Any]?) -> Void)?

    public static func logEvent(_ name: String, parameters: [String: Any]?) {
        logEventNameStringParametersStringAnyVoidCallsCount += 1
        logEventNameStringParametersStringAnyVoidReceivedArguments = (name: name, parameters: parameters)
        logEventNameStringParametersStringAnyVoidReceivedInvocations.append((name: name, parameters: parameters))
        logEventNameStringParametersStringAnyVoidClosure?(name, parameters)
    }

    //MARK: - setAnalyticsCollectionEnabled

    public static var setAnalyticsCollectionEnabledEnabledBoolVoidCallsCount = 0
    public static var setAnalyticsCollectionEnabledEnabledBoolVoidCalled: Bool {
        return setAnalyticsCollectionEnabledEnabledBoolVoidCallsCount > 0
    }
    public static var setAnalyticsCollectionEnabledEnabledBoolVoidReceivedEnabled: (Bool)?
    public static var setAnalyticsCollectionEnabledEnabledBoolVoidReceivedInvocations: [(Bool)] = []
    public static var setAnalyticsCollectionEnabledEnabledBoolVoidClosure: ((Bool) -> Void)?

    public static func setAnalyticsCollectionEnabled(_ enabled: Bool) {
        setAnalyticsCollectionEnabledEnabledBoolVoidCallsCount += 1
        setAnalyticsCollectionEnabledEnabledBoolVoidReceivedEnabled = enabled
        setAnalyticsCollectionEnabledEnabledBoolVoidReceivedInvocations.append(enabled)
        setAnalyticsCollectionEnabledEnabledBoolVoidClosure?(enabled)
    }

    //MARK: - setUserID

    public static var setUserIDUserIdStringVoidCallsCount = 0
    public static var setUserIDUserIdStringVoidCalled: Bool {
        return setUserIDUserIdStringVoidCallsCount > 0
    }
    public static var setUserIDUserIdStringVoidReceivedUserId: (String)?
    public static var setUserIDUserIdStringVoidReceivedInvocations: [(String)?] = []
    public static var setUserIDUserIdStringVoidClosure: ((String?) -> Void)?

    public static func setUserID(_ userId: String?) {
        setUserIDUserIdStringVoidCallsCount += 1
        setUserIDUserIdStringVoidReceivedUserId = userId
        setUserIDUserIdStringVoidReceivedInvocations.append(userId)
        setUserIDUserIdStringVoidClosure?(userId)
    }

    //MARK: - setUserProperty

    public static var setUserPropertyValueStringForNameStringVoidCallsCount = 0
    public static var setUserPropertyValueStringForNameStringVoidCalled: Bool {
        return setUserPropertyValueStringForNameStringVoidCallsCount > 0
    }
    public static var setUserPropertyValueStringForNameStringVoidReceivedArguments: (value: String?, forName: String)?
    public static var setUserPropertyValueStringForNameStringVoidReceivedInvocations: [(value: String?, forName: String)] = []
    public static var setUserPropertyValueStringForNameStringVoidClosure: ((String?, String) -> Void)?

    public static func setUserProperty(_ value: String?, forName: String) {
        setUserPropertyValueStringForNameStringVoidCallsCount += 1
        setUserPropertyValueStringForNameStringVoidReceivedArguments = (value: value, forName: forName)
        setUserPropertyValueStringForNameStringVoidReceivedInvocations.append((value: value, forName: forName))
        setUserPropertyValueStringForNameStringVoidClosure?(value, forName)
    }


}
public class InstabugServiceAdapterMock: InstabugServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - logUserEvent
        logUserEventWithNameStringVoidCallsCount = 0
        logUserEventWithNameStringVoidReceivedWithName = nil
        logUserEventWithNameStringVoidReceivedInvocations = []
        logUserEventWithNameStringVoidClosure = nil


         //MARK: - removeUserAttribute
        removeUserAttributeForKeyStringVoidCallsCount = 0
        removeUserAttributeForKeyStringVoidReceivedForKey = nil
        removeUserAttributeForKeyStringVoidReceivedInvocations = []
        removeUserAttributeForKeyStringVoidClosure = nil


         //MARK: - setUserAttribute
        setUserAttributeValueStringWithKeyStringVoidCallsCount = 0
        setUserAttributeValueStringWithKeyStringVoidReceivedArguments = nil
        setUserAttributeValueStringWithKeyStringVoidReceivedInvocations = []
        setUserAttributeValueStringWithKeyStringVoidClosure = nil


    }

    //MARK: - logUserEvent

    public static var logUserEventWithNameStringVoidCallsCount = 0
    public static var logUserEventWithNameStringVoidCalled: Bool {
        return logUserEventWithNameStringVoidCallsCount > 0
    }
    public static var logUserEventWithNameStringVoidReceivedWithName: (String)?
    public static var logUserEventWithNameStringVoidReceivedInvocations: [(String)] = []
    public static var logUserEventWithNameStringVoidClosure: ((String) -> Void)?

    public static func logUserEvent(withName: String) {
        logUserEventWithNameStringVoidCallsCount += 1
        logUserEventWithNameStringVoidReceivedWithName = withName
        logUserEventWithNameStringVoidReceivedInvocations.append(withName)
        logUserEventWithNameStringVoidClosure?(withName)
    }

    //MARK: - removeUserAttribute

    public static var removeUserAttributeForKeyStringVoidCallsCount = 0
    public static var removeUserAttributeForKeyStringVoidCalled: Bool {
        return removeUserAttributeForKeyStringVoidCallsCount > 0
    }
    public static var removeUserAttributeForKeyStringVoidReceivedForKey: (String)?
    public static var removeUserAttributeForKeyStringVoidReceivedInvocations: [(String)] = []
    public static var removeUserAttributeForKeyStringVoidClosure: ((String) -> Void)?

    public static func removeUserAttribute(forKey: String) {
        removeUserAttributeForKeyStringVoidCallsCount += 1
        removeUserAttributeForKeyStringVoidReceivedForKey = forKey
        removeUserAttributeForKeyStringVoidReceivedInvocations.append(forKey)
        removeUserAttributeForKeyStringVoidClosure?(forKey)
    }

    //MARK: - setUserAttribute

    public static var setUserAttributeValueStringWithKeyStringVoidCallsCount = 0
    public static var setUserAttributeValueStringWithKeyStringVoidCalled: Bool {
        return setUserAttributeValueStringWithKeyStringVoidCallsCount > 0
    }
    public static var setUserAttributeValueStringWithKeyStringVoidReceivedArguments: (value: String, withKey: String)?
    public static var setUserAttributeValueStringWithKeyStringVoidReceivedInvocations: [(value: String, withKey: String)] = []
    public static var setUserAttributeValueStringWithKeyStringVoidClosure: ((String, String) -> Void)?

    public static func setUserAttribute(_ value: String, withKey: String) {
        setUserAttributeValueStringWithKeyStringVoidCallsCount += 1
        setUserAttributeValueStringWithKeyStringVoidReceivedArguments = (value: value, withKey: withKey)
        setUserAttributeValueStringWithKeyStringVoidReceivedInvocations.append((value: value, withKey: withKey))
        setUserAttributeValueStringWithKeyStringVoidClosure?(value, withKey)
    }


}
public class MixpanelServiceAdapterMock: MixpanelServiceAdapter {

    public init() {}



    //MARK: - identify

    public var identifyDistinctIdStringVoidCallsCount = 0
    public var identifyDistinctIdStringVoidCalled: Bool {
        return identifyDistinctIdStringVoidCallsCount > 0
    }
    public var identifyDistinctIdStringVoidReceivedDistinctId: (String)?
    public var identifyDistinctIdStringVoidReceivedInvocations: [(String)] = []
    public var identifyDistinctIdStringVoidClosure: ((String) -> Void)?

    public func identify(_ distinctId: String) {
        identifyDistinctIdStringVoidCallsCount += 1
        identifyDistinctIdStringVoidReceivedDistinctId = distinctId
        identifyDistinctIdStringVoidReceivedInvocations.append(distinctId)
        identifyDistinctIdStringVoidClosure?(distinctId)
    }

    //MARK: - resetUserId

    public var resetUserIdVoidCallsCount = 0
    public var resetUserIdVoidCalled: Bool {
        return resetUserIdVoidCallsCount > 0
    }
    public var resetUserIdVoidClosure: (() -> Void)?

    public func resetUserId() {
        resetUserIdVoidCallsCount += 1
        resetUserIdVoidClosure?()
    }

    //MARK: - hasOptedOutTracking

    public var hasOptedOutTrackingBoolCallsCount = 0
    public var hasOptedOutTrackingBoolCalled: Bool {
        return hasOptedOutTrackingBoolCallsCount > 0
    }
    public var hasOptedOutTrackingBoolReturnValue: Bool!
    public var hasOptedOutTrackingBoolClosure: (() -> Bool)?

    public func hasOptedOutTracking() -> Bool {
        hasOptedOutTrackingBoolCallsCount += 1
        if let hasOptedOutTrackingBoolClosure = hasOptedOutTrackingBoolClosure {
            return hasOptedOutTrackingBoolClosure()
        } else {
            return hasOptedOutTrackingBoolReturnValue
        }
    }

    //MARK: - optInTracking

    public var optInTrackingVoidCallsCount = 0
    public var optInTrackingVoidCalled: Bool {
        return optInTrackingVoidCallsCount > 0
    }
    public var optInTrackingVoidClosure: (() -> Void)?

    public func optInTracking() {
        optInTrackingVoidCallsCount += 1
        optInTrackingVoidClosure?()
    }

    //MARK: - optOutTracking

    public var optOutTrackingVoidCallsCount = 0
    public var optOutTrackingVoidCalled: Bool {
        return optOutTrackingVoidCallsCount > 0
    }
    public var optOutTrackingVoidClosure: (() -> Void)?

    public func optOutTracking() {
        optOutTrackingVoidCallsCount += 1
        optOutTrackingVoidClosure?()
    }

    //MARK: - set

    public var setPropertyStringToValueStringVoidCallsCount = 0
    public var setPropertyStringToValueStringVoidCalled: Bool {
        return setPropertyStringToValueStringVoidCallsCount > 0
    }
    public var setPropertyStringToValueStringVoidReceivedArguments: (property: String, value: String)?
    public var setPropertyStringToValueStringVoidReceivedInvocations: [(property: String, value: String)] = []
    public var setPropertyStringToValueStringVoidClosure: ((String, String) -> Void)?

    public func set(property: String, to value: String) {
        setPropertyStringToValueStringVoidCallsCount += 1
        setPropertyStringToValueStringVoidReceivedArguments = (property: property, value: value)
        setPropertyStringToValueStringVoidReceivedInvocations.append((property: property, value: value))
        setPropertyStringToValueStringVoidClosure?(property, value)
    }

    //MARK: - track

    public var trackEventStringPropertiesAnyHashableAnyVoidCallsCount = 0
    public var trackEventStringPropertiesAnyHashableAnyVoidCalled: Bool {
        return trackEventStringPropertiesAnyHashableAnyVoidCallsCount > 0
    }
    public var trackEventStringPropertiesAnyHashableAnyVoidReceivedArguments: (event: String, properties: [AnyHashable: Any]?)?
    public var trackEventStringPropertiesAnyHashableAnyVoidReceivedInvocations: [(event: String, properties: [AnyHashable: Any]?)] = []
    public var trackEventStringPropertiesAnyHashableAnyVoidClosure: ((String, [AnyHashable: Any]?) -> Void)?

    public func track(_ event: String, properties: [AnyHashable: Any]?) {
        trackEventStringPropertiesAnyHashableAnyVoidCallsCount += 1
        trackEventStringPropertiesAnyHashableAnyVoidReceivedArguments = (event: event, properties: properties)
        trackEventStringPropertiesAnyHashableAnyVoidReceivedInvocations.append((event: event, properties: properties))
        trackEventStringPropertiesAnyHashableAnyVoidClosure?(event, properties)
    }

    //MARK: - unset

    public var unsetPropertiesStringVoidCallsCount = 0
    public var unsetPropertiesStringVoidCalled: Bool {
        return unsetPropertiesStringVoidCallsCount > 0
    }
    public var unsetPropertiesStringVoidReceivedProperties: ([String])?
    public var unsetPropertiesStringVoidReceivedInvocations: [([String])] = []
    public var unsetPropertiesStringVoidClosure: (([String]) -> Void)?

    public func unset(properties: [String]) {
        unsetPropertiesStringVoidCallsCount += 1
        unsetPropertiesStringVoidReceivedProperties = properties
        unsetPropertiesStringVoidReceivedInvocations.append(properties)
        unsetPropertiesStringVoidClosure?(properties)
    }


}
public class ScreenMock: Screen {

    public init() {}

    public var name: String {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }
    public var underlyingName: (String)!
    public var excludedTags: [Tag] = []
    public var requiredTags: [Tag] = []



}
public class ServiceMock: Service {

    public init() {}

    public var supportedTags: [Tag] = []
    public var trackingDisabled: Bool {
        get { return underlyingTrackingDisabled }
        set(value) { underlyingTrackingDisabled = value }
    }
    public var underlyingTrackingDisabled: (Bool)!


    //MARK: - trackEvent

    public var trackEventEventEventVoidCallsCount = 0
    public var trackEventEventEventVoidCalled: Bool {
        return trackEventEventEventVoidCallsCount > 0
    }
    public var trackEventEventEventVoidReceivedEvent: (Event)?
    public var trackEventEventEventVoidReceivedInvocations: [(Event)] = []
    public var trackEventEventEventVoidClosure: ((Event) -> Void)?

    public func trackEvent(_ event: Event) {
        trackEventEventEventVoidCallsCount += 1
        trackEventEventEventVoidReceivedEvent = event
        trackEventEventEventVoidReceivedInvocations.append(event)
        trackEventEventEventVoidClosure?(event)
    }

    //MARK: - setUserId

    public var setUserIdUserIdStringVoidCallsCount = 0
    public var setUserIdUserIdStringVoidCalled: Bool {
        return setUserIdUserIdStringVoidCallsCount > 0
    }
    public var setUserIdUserIdStringVoidReceivedUserId: (String)?
    public var setUserIdUserIdStringVoidReceivedInvocations: [(String)] = []
    public var setUserIdUserIdStringVoidClosure: ((String) -> Void)?

    public func setUserId(_ userId: String) {
        setUserIdUserIdStringVoidCallsCount += 1
        setUserIdUserIdStringVoidReceivedUserId = userId
        setUserIdUserIdStringVoidReceivedInvocations.append(userId)
        setUserIdUserIdStringVoidClosure?(userId)
    }

    //MARK: - resetUserId

    public var resetUserIdVoidCallsCount = 0
    public var resetUserIdVoidCalled: Bool {
        return resetUserIdVoidCallsCount > 0
    }
    public var resetUserIdVoidClosure: (() -> Void)?

    public func resetUserId() {
        resetUserIdVoidCallsCount += 1
        resetUserIdVoidClosure?()
    }

    //MARK: - setProperty

    public var setPropertyKeyStringValueStringVoidCallsCount = 0
    public var setPropertyKeyStringValueStringVoidCalled: Bool {
        return setPropertyKeyStringValueStringVoidCallsCount > 0
    }
    public var setPropertyKeyStringValueStringVoidReceivedArguments: (key: String, value: String)?
    public var setPropertyKeyStringValueStringVoidReceivedInvocations: [(key: String, value: String)] = []
    public var setPropertyKeyStringValueStringVoidClosure: ((String, String) -> Void)?

    public func setProperty(_ key: String, value: String) {
        setPropertyKeyStringValueStringVoidCallsCount += 1
        setPropertyKeyStringValueStringVoidReceivedArguments = (key: key, value: value)
        setPropertyKeyStringValueStringVoidReceivedInvocations.append((key: key, value: value))
        setPropertyKeyStringValueStringVoidClosure?(key, value)
    }

    //MARK: - resetProperties

    public var resetPropertiesVoidCallsCount = 0
    public var resetPropertiesVoidCalled: Bool {
        return resetPropertiesVoidCallsCount > 0
    }
    public var resetPropertiesVoidClosure: (() -> Void)?

    public func resetProperties() {
        resetPropertiesVoidCallsCount += 1
        resetPropertiesVoidClosure?()
    }

    //MARK: - trackScreen

    public var trackScreenScreenScreenVoidCallsCount = 0
    public var trackScreenScreenScreenVoidCalled: Bool {
        return trackScreenScreenScreenVoidCallsCount > 0
    }
    public var trackScreenScreenScreenVoidReceivedScreen: (Screen)?
    public var trackScreenScreenScreenVoidReceivedInvocations: [(Screen)] = []
    public var trackScreenScreenScreenVoidClosure: ((Screen) -> Void)?

    public func trackScreen(_ screen: Screen) {
        trackScreenScreenScreenVoidCallsCount += 1
        trackScreenScreenScreenVoidReceivedScreen = screen
        trackScreenScreenScreenVoidReceivedInvocations.append(screen)
        trackScreenScreenScreenVoidClosure?(screen)
    }

    //MARK: - disableTracking

    public var disableTrackingFlagBoolVoidCallsCount = 0
    public var disableTrackingFlagBoolVoidCalled: Bool {
        return disableTrackingFlagBoolVoidCallsCount > 0
    }
    public var disableTrackingFlagBoolVoidReceivedFlag: (Bool)?
    public var disableTrackingFlagBoolVoidReceivedInvocations: [(Bool)] = []
    public var disableTrackingFlagBoolVoidClosure: ((Bool) -> Void)?

    public func disableTracking(_ flag: Bool) {
        disableTrackingFlagBoolVoidCallsCount += 1
        disableTrackingFlagBoolVoidReceivedFlag = flag
        disableTrackingFlagBoolVoidReceivedInvocations.append(flag)
        disableTrackingFlagBoolVoidClosure?(flag)
    }


}
public class SwiftAnalyticsServiceAdapterMock: SwiftAnalyticsServiceAdapter {

    public init() {}



    //MARK: - send

    public var sendEventStringParametersStringStringVoidCallsCount = 0
    public var sendEventStringParametersStringStringVoidCalled: Bool {
        return sendEventStringParametersStringStringVoidCallsCount > 0
    }
    public var sendEventStringParametersStringStringVoidReceivedArguments: (event: String, parameters: [String: String])?
    public var sendEventStringParametersStringStringVoidReceivedInvocations: [(event: String, parameters: [String: String])] = []
    public var sendEventStringParametersStringStringVoidClosure: ((String, [String: String]) -> Void)?

    public func send(_ event: String, parameters: [String: String]) {
        sendEventStringParametersStringStringVoidCallsCount += 1
        sendEventStringParametersStringStringVoidReceivedArguments = (event: event, parameters: parameters)
        sendEventStringParametersStringStringVoidReceivedInvocations.append((event: event, parameters: parameters))
        sendEventStringParametersStringStringVoidClosure?(event, parameters)
    }

    //MARK: - setParameter

    public var setParameterNameStringValueStringVoidCallsCount = 0
    public var setParameterNameStringValueStringVoidCalled: Bool {
        return setParameterNameStringValueStringVoidCallsCount > 0
    }
    public var setParameterNameStringValueStringVoidReceivedArguments: (name: String, value: String)?
    public var setParameterNameStringValueStringVoidReceivedInvocations: [(name: String, value: String)] = []
    public var setParameterNameStringValueStringVoidClosure: ((String, String) -> Void)?

    public func setParameter(name: String, value: String) {
        setParameterNameStringValueStringVoidCallsCount += 1
        setParameterNameStringValueStringVoidReceivedArguments = (name: name, value: value)
        setParameterNameStringValueStringVoidReceivedInvocations.append((name: name, value: value))
        setParameterNameStringValueStringVoidClosure?(name, value)
    }

    //MARK: - resetParameters

    public var resetParametersVoidCallsCount = 0
    public var resetParametersVoidCalled: Bool {
        return resetParametersVoidCallsCount > 0
    }
    public var resetParametersVoidClosure: (() -> Void)?

    public func resetParameters() {
        resetParametersVoidCallsCount += 1
        resetParametersVoidClosure?()
    }


}
public class SwiftLoggerServiceAdapterMock: SwiftLoggerServiceAdapter {

    public init() {}



    //MARK: - log

    public var logMessageStringVoidCallsCount = 0
    public var logMessageStringVoidCalled: Bool {
        return logMessageStringVoidCallsCount > 0
    }
    public var logMessageStringVoidReceivedMessage: (String)?
    public var logMessageStringVoidReceivedInvocations: [(String)] = []
    public var logMessageStringVoidClosure: ((String) -> Void)?

    public func log(_ message: String) {
        logMessageStringVoidCallsCount += 1
        logMessageStringVoidReceivedMessage = message
        logMessageStringVoidReceivedInvocations.append(message)
        logMessageStringVoidClosure?(message)
    }


}
public class SwiftMetricsServiceAdapterMock: SwiftMetricsServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - incrementCounter
        incrementCounterLabelStringDimensionsStringStringVoidCallsCount = 0
        incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments = nil
        incrementCounterLabelStringDimensionsStringStringVoidReceivedInvocations = []
        incrementCounterLabelStringDimensionsStringStringVoidClosure = nil


    }

    //MARK: - incrementCounter

    public static var incrementCounterLabelStringDimensionsStringStringVoidCallsCount = 0
    public static var incrementCounterLabelStringDimensionsStringStringVoidCalled: Bool {
        return incrementCounterLabelStringDimensionsStringStringVoidCallsCount > 0
    }
    public static var incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments: (label: String, dimensions: [(String, String)])?
    public static var incrementCounterLabelStringDimensionsStringStringVoidReceivedInvocations: [(label: String, dimensions: [(String, String)])] = []
    public static var incrementCounterLabelStringDimensionsStringStringVoidClosure: ((String, [(String, String)]) -> Void)?

    public static func incrementCounter(_ label: String, dimensions: [(String, String)]) {
        incrementCounterLabelStringDimensionsStringStringVoidCallsCount += 1
        incrementCounterLabelStringDimensionsStringStringVoidReceivedArguments = (label: label, dimensions: dimensions)
        incrementCounterLabelStringDimensionsStringStringVoidReceivedInvocations.append((label: label, dimensions: dimensions))
        incrementCounterLabelStringDimensionsStringStringVoidClosure?(label, dimensions)
    }


}
public class TaggableMock: Taggable {

    public init() {}

    public var excludedTags: [Tag] = []
    public var requiredTags: [Tag] = []



}
public class TaplyticsServiceAdapterMock: TaplyticsServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - hasUserOptedOutTracking
        hasUserOptedOutTrackingBoolCallsCount = 0
        hasUserOptedOutTrackingBoolClosure = nil


         //MARK: - logEvent
        logEventEventNameStringVoidCallsCount = 0
        logEventEventNameStringVoidReceivedEventName = nil
        logEventEventNameStringVoidReceivedInvocations = []
        logEventEventNameStringVoidClosure = nil


         //MARK: - optOutUserTracking
        optOutUserTrackingVoidCallsCount = 0
        optOutUserTrackingVoidClosure = nil


         //MARK: - optInUserTracking
        optInUserTrackingVoidCallsCount = 0
        optInUserTrackingVoidClosure = nil


         //MARK: - setUserAttributes
        setUserAttributesAttributesAnyHashableAnyVoidCallsCount = 0
        setUserAttributesAttributesAnyHashableAnyVoidReceivedAttributes = nil
        setUserAttributesAttributesAnyHashableAnyVoidReceivedInvocations = []
        setUserAttributesAttributesAnyHashableAnyVoidClosure = nil


    }

    //MARK: - hasUserOptedOutTracking

    public static var hasUserOptedOutTrackingBoolCallsCount = 0
    public static var hasUserOptedOutTrackingBoolCalled: Bool {
        return hasUserOptedOutTrackingBoolCallsCount > 0
    }
    public static var hasUserOptedOutTrackingBoolReturnValue: Bool!
    public static var hasUserOptedOutTrackingBoolClosure: (() -> Bool)?

    public static func hasUserOptedOutTracking() -> Bool {
        hasUserOptedOutTrackingBoolCallsCount += 1
        if let hasUserOptedOutTrackingBoolClosure = hasUserOptedOutTrackingBoolClosure {
            return hasUserOptedOutTrackingBoolClosure()
        } else {
            return hasUserOptedOutTrackingBoolReturnValue
        }
    }

    //MARK: - logEvent

    public static var logEventEventNameStringVoidCallsCount = 0
    public static var logEventEventNameStringVoidCalled: Bool {
        return logEventEventNameStringVoidCallsCount > 0
    }
    public static var logEventEventNameStringVoidReceivedEventName: (String)?
    public static var logEventEventNameStringVoidReceivedInvocations: [(String)] = []
    public static var logEventEventNameStringVoidClosure: ((String) -> Void)?

    public static func logEvent(_ eventName: String) {
        logEventEventNameStringVoidCallsCount += 1
        logEventEventNameStringVoidReceivedEventName = eventName
        logEventEventNameStringVoidReceivedInvocations.append(eventName)
        logEventEventNameStringVoidClosure?(eventName)
    }

    //MARK: - optOutUserTracking

    public static var optOutUserTrackingVoidCallsCount = 0
    public static var optOutUserTrackingVoidCalled: Bool {
        return optOutUserTrackingVoidCallsCount > 0
    }
    public static var optOutUserTrackingVoidClosure: (() -> Void)?

    public static func optOutUserTracking() {
        optOutUserTrackingVoidCallsCount += 1
        optOutUserTrackingVoidClosure?()
    }

    //MARK: - optInUserTracking

    public static var optInUserTrackingVoidCallsCount = 0
    public static var optInUserTrackingVoidCalled: Bool {
        return optInUserTrackingVoidCallsCount > 0
    }
    public static var optInUserTrackingVoidClosure: (() -> Void)?

    public static func optInUserTracking() {
        optInUserTrackingVoidCallsCount += 1
        optInUserTrackingVoidClosure?()
    }

    //MARK: - setUserAttributes

    public static var setUserAttributesAttributesAnyHashableAnyVoidCallsCount = 0
    public static var setUserAttributesAttributesAnyHashableAnyVoidCalled: Bool {
        return setUserAttributesAttributesAnyHashableAnyVoidCallsCount > 0
    }
    public static var setUserAttributesAttributesAnyHashableAnyVoidReceivedAttributes: ([AnyHashable: Any])?
    public static var setUserAttributesAttributesAnyHashableAnyVoidReceivedInvocations: [([AnyHashable: Any])?] = []
    public static var setUserAttributesAttributesAnyHashableAnyVoidClosure: (([AnyHashable: Any]?) -> Void)?

    public static func setUserAttributes(_ attributes: [AnyHashable: Any]?) {
        setUserAttributesAttributesAnyHashableAnyVoidCallsCount += 1
        setUserAttributesAttributesAnyHashableAnyVoidReceivedAttributes = attributes
        setUserAttributesAttributesAnyHashableAnyVoidReceivedInvocations.append(attributes)
        setUserAttributesAttributesAnyHashableAnyVoidClosure?(attributes)
    }


}
public class UXCamServiceAdapterMock: UXCamServiceAdapter {

    public init() {}


    static func reset()
    {
         //MARK: - logEvent
        logEventEventNameStringWithPropertiesStringAnyVoidCallsCount = 0
        logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments = nil
        logEventEventNameStringWithPropertiesStringAnyVoidReceivedInvocations = []
        logEventEventNameStringWithPropertiesStringAnyVoidClosure = nil


         //MARK: - optInOverall
        optInOverallVoidCallsCount = 0
        optInOverallVoidClosure = nil


         //MARK: - optInOverallStatus
        optInOverallStatusBoolCallsCount = 0
        optInOverallStatusBoolClosure = nil


         //MARK: - optOutOverall
        optOutOverallVoidCallsCount = 0
        optOutOverallVoidClosure = nil


         //MARK: - setUserIdentity
        setUserIdentityUserIdentityStringVoidCallsCount = 0
        setUserIdentityUserIdentityStringVoidReceivedUserIdentity = nil
        setUserIdentityUserIdentityStringVoidReceivedInvocations = []
        setUserIdentityUserIdentityStringVoidClosure = nil


         //MARK: - setUserProperty
        setUserPropertyPropertyNameStringValueAnyVoidCallsCount = 0
        setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments = nil
        setUserPropertyPropertyNameStringValueAnyVoidReceivedInvocations = []
        setUserPropertyPropertyNameStringValueAnyVoidClosure = nil


         //MARK: - tagScreenName
        tagScreenNameScreenNameStringVoidCallsCount = 0
        tagScreenNameScreenNameStringVoidReceivedScreenName = nil
        tagScreenNameScreenNameStringVoidReceivedInvocations = []
        tagScreenNameScreenNameStringVoidClosure = nil


    }

    //MARK: - logEvent

    public static var logEventEventNameStringWithPropertiesStringAnyVoidCallsCount = 0
    public static var logEventEventNameStringWithPropertiesStringAnyVoidCalled: Bool {
        return logEventEventNameStringWithPropertiesStringAnyVoidCallsCount > 0
    }
    public static var logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments: (eventName: String, withProperties: [String: Any]?)?
    public static var logEventEventNameStringWithPropertiesStringAnyVoidReceivedInvocations: [(eventName: String, withProperties: [String: Any]?)] = []
    public static var logEventEventNameStringWithPropertiesStringAnyVoidClosure: ((String, [String: Any]?) -> Void)?

    public static func logEvent(_ eventName: String, withProperties: [String: Any]?) {
        logEventEventNameStringWithPropertiesStringAnyVoidCallsCount += 1
        logEventEventNameStringWithPropertiesStringAnyVoidReceivedArguments = (eventName: eventName, withProperties: withProperties)
        logEventEventNameStringWithPropertiesStringAnyVoidReceivedInvocations.append((eventName: eventName, withProperties: withProperties))
        logEventEventNameStringWithPropertiesStringAnyVoidClosure?(eventName, withProperties)
    }

    //MARK: - optInOverall

    public static var optInOverallVoidCallsCount = 0
    public static var optInOverallVoidCalled: Bool {
        return optInOverallVoidCallsCount > 0
    }
    public static var optInOverallVoidClosure: (() -> Void)?

    public static func optInOverall() {
        optInOverallVoidCallsCount += 1
        optInOverallVoidClosure?()
    }

    //MARK: - optInOverallStatus

    public static var optInOverallStatusBoolCallsCount = 0
    public static var optInOverallStatusBoolCalled: Bool {
        return optInOverallStatusBoolCallsCount > 0
    }
    public static var optInOverallStatusBoolReturnValue: Bool!
    public static var optInOverallStatusBoolClosure: (() -> Bool)?

    public static func optInOverallStatus() -> Bool {
        optInOverallStatusBoolCallsCount += 1
        if let optInOverallStatusBoolClosure = optInOverallStatusBoolClosure {
            return optInOverallStatusBoolClosure()
        } else {
            return optInOverallStatusBoolReturnValue
        }
    }

    //MARK: - optOutOverall

    public static var optOutOverallVoidCallsCount = 0
    public static var optOutOverallVoidCalled: Bool {
        return optOutOverallVoidCallsCount > 0
    }
    public static var optOutOverallVoidClosure: (() -> Void)?

    public static func optOutOverall() {
        optOutOverallVoidCallsCount += 1
        optOutOverallVoidClosure?()
    }

    //MARK: - setUserIdentity

    public static var setUserIdentityUserIdentityStringVoidCallsCount = 0
    public static var setUserIdentityUserIdentityStringVoidCalled: Bool {
        return setUserIdentityUserIdentityStringVoidCallsCount > 0
    }
    public static var setUserIdentityUserIdentityStringVoidReceivedUserIdentity: (String)?
    public static var setUserIdentityUserIdentityStringVoidReceivedInvocations: [(String)] = []
    public static var setUserIdentityUserIdentityStringVoidClosure: ((String) -> Void)?

    public static func setUserIdentity(_ userIdentity: String) {
        setUserIdentityUserIdentityStringVoidCallsCount += 1
        setUserIdentityUserIdentityStringVoidReceivedUserIdentity = userIdentity
        setUserIdentityUserIdentityStringVoidReceivedInvocations.append(userIdentity)
        setUserIdentityUserIdentityStringVoidClosure?(userIdentity)
    }

    //MARK: - setUserProperty

    public static var setUserPropertyPropertyNameStringValueAnyVoidCallsCount = 0
    public static var setUserPropertyPropertyNameStringValueAnyVoidCalled: Bool {
        return setUserPropertyPropertyNameStringValueAnyVoidCallsCount > 0
    }
    public static var setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments: (propertyName: String, value: Any)?
    public static var setUserPropertyPropertyNameStringValueAnyVoidReceivedInvocations: [(propertyName: String, value: Any)] = []
    public static var setUserPropertyPropertyNameStringValueAnyVoidClosure: ((String, Any) -> Void)?

    public static func setUserProperty(_ propertyName: String, value: Any) {
        setUserPropertyPropertyNameStringValueAnyVoidCallsCount += 1
        setUserPropertyPropertyNameStringValueAnyVoidReceivedArguments = (propertyName: propertyName, value: value)
        setUserPropertyPropertyNameStringValueAnyVoidReceivedInvocations.append((propertyName: propertyName, value: value))
        setUserPropertyPropertyNameStringValueAnyVoidClosure?(propertyName, value)
    }

    //MARK: - tagScreenName

    public static var tagScreenNameScreenNameStringVoidCallsCount = 0
    public static var tagScreenNameScreenNameStringVoidCalled: Bool {
        return tagScreenNameScreenNameStringVoidCallsCount > 0
    }
    public static var tagScreenNameScreenNameStringVoidReceivedScreenName: (String)?
    public static var tagScreenNameScreenNameStringVoidReceivedInvocations: [(String)] = []
    public static var tagScreenNameScreenNameStringVoidClosure: ((String) -> Void)?

    public static func tagScreenName(_ screenName: String) {
        tagScreenNameScreenNameStringVoidCallsCount += 1
        tagScreenNameScreenNameStringVoidReceivedScreenName = screenName
        tagScreenNameScreenNameStringVoidReceivedInvocations.append(screenName)
        tagScreenNameScreenNameStringVoidClosure?(screenName)
    }


}

