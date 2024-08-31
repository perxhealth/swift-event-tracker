import class Countly.Countly
import class Countly.CountlyUserDetails
import protocol Tracker.CountlyServiceAdapter
import protocol Tracker.CountlyUserDetailsAdapter

extension Countly: CountlyServiceAdapter {
    public func userLogged(in userID: String) {
        self.changeDeviceIDWithoutMerge(userID)
    }
    
    public func userLoggedOut() {
        self.changeDeviceIDWithoutMerge(nil)
    }
}

extension CountlyUserDetails: CountlyUserDetailsAdapter {}
