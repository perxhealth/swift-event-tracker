import Foundation
import Tracker

extension EventMock {
    public convenience init(name: String,
                            parameters: [Parameter] = [],
                            requiredTags: [Tag] = [],
                            excludedTags: [Tag] = []) {
        self.init()
        self.underlyingName = name
        self.parameters = parameters
        self.requiredTags = requiredTags
        self.excludedTags = excludedTags
    }
}
