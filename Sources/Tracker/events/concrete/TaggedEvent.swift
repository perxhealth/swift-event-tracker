import Foundation

public struct TaggedEvent: Event {
    public let name: String
    public let parameters: [Parameter]
    public let excludedTags: [Tag]
    public let requiredTags: [Tag]

    public init(name: String, parameters: [Parameter], excludedTags: [Tag], requiredTags: [Tag]) {
        self.name = name
        self.parameters = parameters
        self.excludedTags = excludedTags
        self.requiredTags = requiredTags
    }
}
