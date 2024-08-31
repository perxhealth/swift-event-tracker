import Foundation

public final class SwiftAnalyticsServiceProvider: AbstractProvider, Service {
    public let supportedTags: [Tag] = [.swiftAnalytics, .analytics]

    private var adapter: SwiftAnalyticsServiceAdapter

    public init(adapter: SwiftAnalyticsServiceAdapter) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        adapter.send(event.name, parameters: event.parameters)
    }

    public func setProperty(_ key: String, value: String) {
        userProperties[key] = value
        adapter.setParameter(name: key, value: value)
    }

    public func resetProperties() {
        userProperties = [:]
        adapter.resetParameters()
    }
}
