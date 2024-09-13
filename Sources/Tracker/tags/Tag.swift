import Foundation

public struct Tag: Codable, Hashable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public static let analytics = Tag("analytics")
    public static let crashReporting = Tag("crashReporting")
    public static let debugging = Tag("debugging")
    public static let logging = Tag("logging")

    public static let nativeEventParameters = Tag("nativeEventParameters")
    public static let nativeProperties = Tag("nativeProperties")
    public static let nativeScreen = Tag("nativeScreen")
    public static let nativeUserId = Tag("nativeUserId")

    private let identifier: String

    public init(_ identifier: String) {
        self.identifier = identifier
    }

    public init(stringLiteral value: String) {
        self.identifier = value
    }

    public init(stringInterpolation value: DefaultStringInterpolation) {
        self.identifier = value.description
    }
}
