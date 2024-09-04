import Foundation

// sourcery: AutoMockable
public protocol SegmentScreen: Screen {
    var category: String? { get }
    var properties: [String: Any] { get }
}
