import Foundation

infix operator +: AdditionPrecedence

public func + (left: NamedEvent, right: [any Parameter]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters.appending(contentsOf: right),
                excludedTags: left.excludedTags,
                requiredTags: left.requiredTags)
}

public func + (left: ParameterizedEvent, right: [any Parameter]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters.appending(contentsOf: right),
                excludedTags: left.excludedTags,
                requiredTags: left.requiredTags)
}

public func + (left: TaggedEvent, right: [any Parameter]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters.appending(contentsOf: right),
                excludedTags: left.excludedTags,
                requiredTags: left.requiredTags)
}

public func + (left: NamedEvent, right: Tag) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.removing(right),
                requiredTags: left.requiredTags.appending(right).removingDuplicates())
}

public func + (left: ParameterizedEvent, right: Tag) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.removing(right),
                requiredTags: left.requiredTags.appending(right).removingDuplicates())
}

public func + (left: TaggedEvent, right: Tag) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.removing(right),
                requiredTags: left.requiredTags.appending(right).removingDuplicates())
}

public func + (left: NamedEvent, right: [Tag]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.removing(right),
                requiredTags: left.requiredTags.appending(contentsOf: right).removingDuplicates())
}

public func + (left: ParameterizedEvent, right: [Tag]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.removing(right),
                requiredTags: left.requiredTags.appending(contentsOf: right).removingDuplicates())
}

public func + (left: TaggedEvent, right: [Tag]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.removing(right),
                requiredTags: left.requiredTags.appending(contentsOf: right).removingDuplicates())
}

infix operator -: AdditionPrecedence

public func - (left: NamedEvent, right: Tag) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.appending(right).removingDuplicates(),
                requiredTags: left.requiredTags.removing(right))
}

public func - (left: ParameterizedEvent, right: Tag) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.appending(right).removingDuplicates(),
                requiredTags: left.requiredTags.removing(right))
}

public func - (left: TaggedEvent, right: Tag) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.appending(right).removingDuplicates(),
                requiredTags: left.requiredTags.removing(right))
}

public func - (left: NamedEvent, right: [Tag]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.appending(contentsOf: right).removingDuplicates(),
                requiredTags: left.requiredTags.removing(right))
}

public func - (left: ParameterizedEvent, right: [Tag]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.appending(contentsOf: right).removingDuplicates(),
                requiredTags: left.requiredTags.removing(right))
}

public func - (left: TaggedEvent, right: [Tag]) -> TaggedEvent {
    TaggedEvent(name: left.name,
                parameters: left.parameters,
                excludedTags: left.excludedTags.appending(contentsOf: right).removingDuplicates(),
                requiredTags: left.requiredTags.removing(right))
}
