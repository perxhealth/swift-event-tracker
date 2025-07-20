import Foundation

public struct ProviderEvent: Event {
    public let name: String
    public let _parameters: [any Parameter]
    public let providerTags: [Tag]

    public init(name: String, parameters: [any Parameter], providerTags: [Tag]) {
        self.name = name
        self._parameters = parameters
        self.providerTags = providerTags
    }
    
    public var parameters: [any Parameter] {
        return _parameters.filter { param in
            return providerTags.containsNone(from: param.excludedTags) && providerTags.containsAny(from: param.requiredTags)
        }
    }
}
