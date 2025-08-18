import Foundation

public struct TaggedParameter: Parameter, Equatable {
    public let parameter: any Parameter
    public let excludedTags: [Tag]
    public let requiredTags: [Tag]
    
    public var key: String { parameter.key }
    public var value: String { parameter.value }
    
    public init(parameter: any Parameter, excludedTags: [Tag] = [], requiredTags: [Tag] = []) {
        self.parameter = parameter
        self.excludedTags = parameter.excludedTags + excludedTags
        self.requiredTags = parameter.requiredTags + requiredTags
    }
    
    public init(key: String, value: String, excludedTags: [Tag] = [], requiredTags: [Tag] = []) {
        self.parameter = NamedParameter(key: key, value: value)
        self.excludedTags = parameter.excludedTags + excludedTags
        self.requiredTags = parameter.requiredTags + requiredTags
    }
    
    public static func == (lhs: TaggedParameter, rhs: TaggedParameter) -> Bool {
        lhs.parameter.key == rhs.parameter.key && lhs.parameter.value == rhs.parameter.value
    }
}
