import Foundation

open class AbstractProvider {
    public static var defaultFallbackUserIdPropertyKey: String = "user-id"

    public private(set) var trackingDisabled: Bool = false

    var userIdPropertyKey: String?
    var userProperties: [String: Any] = [:]

    public init(userIdPropertyKey: String? = nil) {
        self.userIdPropertyKey = userIdPropertyKey
    }

    open func disableTracking(_ flag: Bool) {
        trackingDisabled = flag
    }
}
