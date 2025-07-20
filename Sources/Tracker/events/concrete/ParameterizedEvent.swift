import Foundation

public struct ParameterizedEvent: Event {
    public let name: String
    public let parameters: [any Parameter]

    public init(name: String, parameters: [any Parameter]) {
        self.name = name
        self.parameters = parameters
    }
}
