import Foundation

public final class AppCenterAnalyticsServiceProvider: AbstractProvider, Service {
    public var supportedTags: [Tag] = [.appCenterAnalytics, .analytics, .nativeEventParameters]

    private let adapter: AppCenterAnalyticsServiceAdapter.Type

    public init(adapter: AppCenterAnalyticsServiceAdapter.Type) {
        self.adapter = adapter
        super.init(userIdPropertyKey: Self.defaultFallbackUserIdPropertyKey)
    }

    public func trackEvent(_ event: Event) {
        adapter.trackEvent(event.name, withProperties: event.parameters)
    }

    public override func disableTracking(_ flag: Bool) {
        super.disableTracking(flag)
        if flag {
            adapter.pause()
        } else {
            adapter.resume()
        }
    }
}
