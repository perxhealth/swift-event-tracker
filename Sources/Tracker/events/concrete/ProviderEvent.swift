import Foundation

public struct ProviderEvent: Event {
    public let name: String
    public let _parameters: [Parameter]
    public let providerTags: [Tag]

    public init(name: String, parameters: [Parameter], providerTags: [Tag]) {
        self.name = name
        self._parameters = parameters
        self.providerTags = providerTags
    }
    
    public var parameters: [Parameter] {
        return _parameters.filter { param in
            !param.excludedTags.contains(providerTags) && param.requiredTags.contains(providerTags)
        }
    }
}
