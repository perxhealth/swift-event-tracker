import Foundation

// sourcery: AutoMockable
public protocol Event: Taggable {
    var name: String { get }
    var parameters: [Parameter] { get }
}

extension Event {
    public var resolvedParameters: [String: String] {
        return parameters.reduce(into: [:]) { result, parameter in
            result[parameter.key] = parameter.value
        }
    }
}
