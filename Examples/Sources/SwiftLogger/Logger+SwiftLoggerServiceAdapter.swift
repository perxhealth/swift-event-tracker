import struct Logging.Logger
import protocol Tracker.SwiftLoggerServiceAdapter

extension Logger: SwiftLoggerServiceAdapter {
    public func log(_ message: String) {
        info(Logger.Message(stringLiteral: message))
    }
}
