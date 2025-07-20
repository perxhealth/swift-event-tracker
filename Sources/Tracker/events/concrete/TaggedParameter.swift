import Foundation

public struct TaggedParameter: Parameter {
    public let parameter: Parameter
    public let excludedTags: [Tag]
    public let requiredTags: [Tag]
    
    public var key: String { parameter.key }
    public var value: String { parameter.value }
    
    public init(parameter: Parameter, excludedTags: [Tag] = [], requiredTags: [Tag] = []) {
        self.parameter = parameter
        self.excludedTags = excludedTags
        self.requiredTags = requiredTags
    }
}
