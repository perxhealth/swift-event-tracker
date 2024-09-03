import Foundation

// sourcery: AutoMockable
public protocol Taggable {
    var excludedTags: [Tag] { get }
    var requiredTags: [Tag] { get }
}

extension Taggable {
    public var excludedTags: [Tag] { [] }
    public var requiredTags: [Tag] { [] }
}
