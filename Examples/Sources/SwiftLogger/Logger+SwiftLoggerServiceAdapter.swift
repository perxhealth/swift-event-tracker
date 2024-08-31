import struct Logging.Logger
import Tracker

extension Logger: SwiftLoggerServiceAdapter {
    public func log(_ message: String) {
        info(Logger.Message(stringLiteral: message))
    }
}
