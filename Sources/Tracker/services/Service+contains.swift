import Foundation

extension Service {
    func containsAny(from tags: [Tag]) -> Bool {
        self.supportedTags.containsAny(from: tags)
    }

    func containsNone(from tags: [Tag]) -> Bool {
        self.supportedTags.containsNone(from: tags)
    }
}

extension Array where Element == Tag {
    func containsAny(from tags: [Tag]) -> Bool {
        guard !tags.isEmpty else {
            return true
        }
        let containsAny = tags.contains { tag in self.contains { $0 == tag } }
        return containsAny
    }

    func containsNone(from tags: [Tag]) -> Bool {
        guard !tags.isEmpty else {
            return true
        }
        return !containsAny(from: tags)
    }
}
