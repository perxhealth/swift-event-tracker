import SwiftAnalytics
import Tracker

extension Analytics: SwiftAnalyticsServiceAdapter {
    public func send(_ event: String, parameters: [String: String]) {
        var typedParameters = Parameters()
        parameters.forEach { key, value in
            typedParameters[key] = .string(value)
        }
        let event = Event(event, parameters: typedParameters)
        send(event)
    }

    public mutating func setParameter(name: String, value: String) {
        parameters[name] = .string(value)
    }

    public mutating func resetParameters() {
        parameters = Parameters()
    }
}
