import Foundation

// MARK: - NamedParameter from String Literal

public func + (key: String, value: String) -> NamedParameter {
    NamedParameter(key: key, value: value)
}

// MARK: - Required Tags

public func + (parameter: Parameter, requiredTags: [Tag]) -> TaggedParameter {
    TaggedParameter(parameter: parameter, requiredTags: requiredTags)
}

public func + (requiredTags: [Tag], parameter: Parameter) -> TaggedParameter {
    parameter + requiredTags
}

public func + (parameter: Parameter, requiredTag: Tag) -> TaggedParameter {
    parameter + [requiredTag]
}

public func + (requiredTag: Tag, property: Parameter) -> TaggedParameter {
    property + requiredTag
}

// MARK: - Excluded Tags

public func - (parameter: Parameter, excludedTags: [Tag]) -> TaggedParameter {
    TaggedParameter(parameter: parameter, excludedTags: excludedTags)
}

public func - (excludedTags: [Tag], parameter: Parameter) -> TaggedParameter {
    parameter - excludedTags
}

public func - (parameter: Parameter, excludedTag: Tag) -> TaggedParameter {
    parameter - [excludedTag]
}

public func - (excludedTag: Tag, parameter: Parameter) -> TaggedParameter {
    parameter - excludedTag
}
