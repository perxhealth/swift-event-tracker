import Foundation

// sourcery: AutoMockable
public protocol PostHogScreen: Screen {
    var properties: [String: Any] { get }
}
