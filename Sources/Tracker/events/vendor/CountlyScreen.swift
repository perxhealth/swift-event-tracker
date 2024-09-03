import Foundation

// sourcery: AutoMockable
public protocol CountlyScreen: Screen {
    var segmentation: [String: String] { get }
}
