import Foundation

public final class SwiftMetricsServiceProvider: AbstractProvider, Service {
    public let supportedTags: [Tag] = [.swiftMetrics, .debugging]

    private let adapter: SwiftMetricsServiceAdapter.Type

    public init(adapter: SwiftMetricsServiceAdapter.Type) {
        self.adapter = adapter
        super.init(userIdPropertyKey: Self.defaultFallbackUserIdPropertyKey)
    }

    public func trackEvent(_ event: Event) {
        if !event.parameters.isEmpty {
            let dimensions = event
                .parameters
                .map { ($0.key, $0.value) }
            adapter.incrementCounter("\(event.name)", dimensions: dimensions)
        } else {
            adapter.incrementCounter("\(event.name)", dimensions: [])
        }
    }
}
