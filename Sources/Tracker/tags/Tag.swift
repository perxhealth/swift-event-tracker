import Foundation

public struct Tag: Equatable {
    public static let analytics = Tag("analytics")
    public static let crashReporting = Tag("crashReporting")
    public static let debugging = Tag("debugging")
    public static let logging = Tag("logging")

    private let identifier: String

    public init(_ identifier: String) {
        self.identifier = identifier
    }
}
