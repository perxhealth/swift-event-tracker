import Foundation

// MARK: - NamedParameter from String Literal

public func + (key: String, value: String) -> NamedParameter {
    NamedParameter(key: key, value: value)
}

// MARK: - Required Tags

public func + (parameter: any Parameter, requiredTags: [Tag]) -> TaggedParameter
{
    TaggedParameter(parameter: parameter, requiredTags: requiredTags)
}

public func + (requiredTags: [Tag], parameter: any Parameter) -> TaggedParameter
{
    parameter + requiredTags
}

public func + (parameter: any Parameter, requiredTag: Tag) -> TaggedParameter {
    parameter + [requiredTag]
}

public func + (requiredTag: Tag, property: any Parameter) -> TaggedParameter {
    property + requiredTag
}

// MARK: - Excluded Tags

public func - (parameter: any Parameter, excludedTags: [Tag]) -> TaggedParameter
{
    TaggedParameter(parameter: parameter, excludedTags: excludedTags)
}

public func - (excludedTags: [Tag], parameter: any Parameter) -> TaggedParameter
{
    parameter - excludedTags
}

public func - (parameter: any Parameter, excludedTag: Tag) -> TaggedParameter {
    parameter - [excludedTag]
}

public func - (excludedTag: Tag, parameter: any Parameter) -> TaggedParameter {
    parameter - excludedTag
}
