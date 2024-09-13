import Analytics
import Tracker

struct CustomMetadata: AnalyticsMetadata, Codable, Hashable {
    let data: [String: String]
}

@available(iOS 16, *)
@available(macOS 13, *)
@available(tvOS 16, *)
@available(watchOS 9, *)
extension MultiplexAnalyticsHandler<String>: SwiftAnalyticsKitServiceAdapter {
    public func fire(_ eventName: String, metadata: [String: String]) {
        let event = SomeAnalyticsEvent<String, CustomMetadata>(name: eventName)
        let metadata = CustomMetadata(data: metadata)
        event.fire(on: self, data: metadata)
    }
}
