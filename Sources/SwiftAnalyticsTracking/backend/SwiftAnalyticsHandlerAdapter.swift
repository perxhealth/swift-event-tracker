import Foundation
import SwiftAnalytics
import Tracker

/**
 [SwiftAnalytics](https://github.com/dankinsoid/swift-analytics) backend.

 Instruct SwiftAnalytics to use your analytics backend as the one the whole application (including all libraries) should use with:
 ```
 AnalyticsSystem.bootstrap(MyAnalyticsHandler())
 ```
 */
public struct SwiftAnalyticsHandlerAdapter: AnalyticsHandler {
    /// The parameters that will be included in all analytics events sent by this handler.
    public var parameters = Analytics.Parameters()

    private let eventTracker: EventTracker

    public init(eventTracker: EventTracker) {
        self.eventTracker = eventTracker
    }

    /// Send an analytics event to the backend.
    public func send(event: Analytics.Event, file: String, function: String, line: UInt, source: String) {
        let allParameters = event.parameters.merging(parameters) { (current, _) in current }
        let dictionary = convertParametersToDictionary(allParameters, function: function, line: line, source: source)
        let parameterizedEvent = ParameterizedEvent(name: event.name, parameters: dictionary)
        eventTracker.trackEvent(parameterizedEvent)
    }

    private func convertParametersToDictionary(_ parameters: Analytics.Parameters, function: String, line: UInt, source: String) -> [String: String] {
        parameters.mapValues { value in
            switch value {
            case .string(let string):
                return string
            case .int(let integer):
                return integer.description
            case .double(let double):
                return double.description
            case .bool(let boolean):
                return boolean ? "true" : "false"
            case .dictionary(let dictionary):
                do {
                    return try convertParameterValueToJson(value)
                } catch {
                    let reason = """
                    Cannot convert \(dictionary) into a JSON string: \(error)
                    Review \(function) at \(source):\(line).
                    """
                    assertionFailure(reason)
                    return ""
                }
            case .array(let array):
                do {
                    return try convertParameterValueToJson(value)
                } catch {
                    let reason = """
                    Cannot convert \(array) into a JSON string: \(error)
                    Review \(function) at \(source):\(line).
                    """
                    assertionFailure(reason)
                    return ""
                }
            }
        }
    }

    private func convertParameterValueToJson(_ value: Analytics.ParametersValue) throws -> String {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(value)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        return json ?? ""
    }
}
