import Foundation

public struct ParameterizedEvent: Event {
    public let name: String
    public let parameters: [Parameter]

    public init(name: String, parameters: [Parameter]) {
        self.name = name
        self.parameters = parameters
    }
}
