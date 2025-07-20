import Foundation
import Tracker

extension EventMock {
    public convenience init(name: String,
                            parameters: [String: String] = [:],
                            requiredTags: [Tag] = [],
                            excludedTags: [Tag] = []) {
        self.init()
        self.underlyingName = name
        self.parameters = parameters.reduce([], { partialResult, value in
            partialResult + [NamedParameter(key: value.key, value: value.value)]
        })
        self.requiredTags = requiredTags
        self.excludedTags = excludedTags
    }
}
