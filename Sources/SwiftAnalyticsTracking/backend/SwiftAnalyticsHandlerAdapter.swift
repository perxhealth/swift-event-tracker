import Foundation
import SwiftAnalytics
import Tracker

/**
 [SwiftAnalytics](https://github.com/dankinsoid/swift-analytics) backend.

 Instruct SwiftAnalytics to use `SwiftAnalyticsHandlerAdapter` as the backend for the whole application (including all libraries) with:
 ```
 AnalyticsSystem.bootstrap(SwiftAnalyticsHandlerAdapter(eventTracker: yourEventTracker))
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
        let dictionary = convertParameters(allParameters, function: function, line: line, source: source)
        let parameterizedEvent = ParameterizedEvent(name: event.name, parameters: dictionary)
        eventTracker.trackEvent(parameterizedEvent)
    }

    private func convertParameters(_ parameters: Analytics.Parameters, function: String, line: UInt, source: String) -> [any Parameter] {
        return parameters.reduce(into: []) { partial, value in
            switch value.value {
            case .string(let string):
                partial.append(NamedParameter(key: value.key, value: string))
            case .int(let integer):
                partial.append(NamedParameter(key: value.key, value: integer.description))
            case .double(let double):
                partial.append(NamedParameter(key: value.key, value: double.description))
            case .bool(let boolean):
                partial.append(NamedParameter(key: value.key, value: boolean ? "true" : "false"))
            case .dictionary(let dictionary):
                do {
                    try partial.append(NamedParameter(key: value.key, value: convertParameterValueToJson(value.value)))
                } catch {
                    let reason = """
                    Cannot convert \(dictionary) into a JSON string: \(error)
                    Review \(function) at \(source):\(line).
                    """
                    assertionFailure(reason)
                    return
                }
            case .array(let array):
                do {
                    try partial.append(NamedParameter(key: value.key, value: convertParameterValueToJson(value.value)))
                } catch {
                    let reason = """
                    Cannot convert \(array) into a JSON string: \(error)
                    Review \(function) at \(source):\(line).
                    """
                    assertionFailure(reason)
                    return
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
