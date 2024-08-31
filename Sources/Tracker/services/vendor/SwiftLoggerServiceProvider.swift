import Foundation

public final class SwiftLoggerServiceProvider: AbstractProvider, Service {
    public let supportedTags: [Tag] = [.swiftLogger, .debugging]

    private let adapter: SwiftLoggerServiceAdapter

    public init(adapter: SwiftLoggerServiceAdapter) {
        self.adapter = adapter
    }

    public func trackEvent(_ event: Event) {
        if !event.parameters.isEmpty {
            let stringParams = event
                .parameters
                .map { $0.key + " = " + $0.value }
                .joined(separator: ", ")
            adapter.log("Tracking event: \(event.name); with parameters: \(stringParams)")
        } else {
            adapter.log("Tracking event: \(event.name)")
        }
    }
}
