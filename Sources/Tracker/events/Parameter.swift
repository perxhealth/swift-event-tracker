import Foundation

// sourcery: AutoMockable
public protocol Parameter: Taggable {
    var key: String { get }
    var value: String { get }
}

extension Parameter {
    public var excludedTags: [Tag] { [] }
    public var requiredTags: [Tag] { [] }
}
