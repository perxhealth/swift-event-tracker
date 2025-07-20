import Foundation

// sourcery: AutoMockable
public protocol Event: Taggable {
    var name: String { get }
    var parameters: [any Parameter] { get }
    var resolvedParameters: [String: String] { get }
}

extension Event {
    public var resolvedParameters: [String: String] {
        let reduced = parameters.reduce(into: [:]) { result, parameter in
            result[parameter.key] = parameter.value
        }
        return reduced
    }
}
