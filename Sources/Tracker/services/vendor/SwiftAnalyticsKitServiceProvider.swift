import Foundation

public final class SwiftAnalyticsKitServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.swiftAnalyticsKit, .analytics, .nativeEventParameters]

    private var adapter: SwiftAnalyticsKitServiceAdapter

    public init(adapter: SwiftAnalyticsKitServiceAdapter) {
        self.adapter = adapter
        super.init(userIdPropertyKey: Self.defaultFallbackUserIdPropertyKey)
    }

    public func trackEvent(_ event: Event) {
        adapter.fire(event.name, metadata: event.parameters)
    }
}
