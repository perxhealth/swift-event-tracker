import class FacebookCore.AppEvents
import class FacebookCore.Settings
import protocol Tracker.FacebookServiceAdapter
import protocol Tracker.FacebookSettingsAdapter

extension AppEvents: FacebookServiceAdapter {
    public func clearUserID() {
        self.userID = nil
    }
    
    public func logEvent(_ eventName: String, parameters: [String: Any]) {
        var namedParameters = [AppEvents.ParameterName: Any]()
        for (key, value) in parameters {
            namedParameters[AppEvents.ParameterName(rawValue: key)] = value
        }
        logEvent(AppEvents.Name(rawValue: eventName), parameters: namedParameters)
    }
}

extension Settings: FacebookSettingsAdapter {}
