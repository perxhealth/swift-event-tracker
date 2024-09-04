import Foundation

public final class SwiftLoggerServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.swiftLogger, .logging]

    private let adapter: SwiftLoggerServiceAdapter

    public init(adapter: SwiftLoggerServiceAdapter) {
        self.adapter = adapter
        super.init(userIdPropertyKey: Self.defaultFallbackUserIdPropertyKey)
    }

    public func trackEvent(_ event: Event) {
        if !event.parameters.isEmpty {
            let stringParams = event
                .parameters
                .map { $0.key + " = " + $0.value }
                .joined(separator: ", ")
            adapter.log("Event: \(event.name); parameters: \(stringParams)")
        } else {
            adapter.log("Event: \(event.name)")
        }
    }
}
