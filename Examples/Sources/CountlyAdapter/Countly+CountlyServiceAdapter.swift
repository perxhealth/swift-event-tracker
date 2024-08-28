import class Countly.Countly
import class Countly.CountlyUserDetails
import Tracker

extension Countly: CountlyServiceAdapter {
    public func userLogged(in userID: String) {
        self.changeDeviceIDWithoutMerge(userID)
    }
    
    public func userLoggedOut() {
        self.changeDeviceIDWithoutMerge(nil)
    }
}

extension CountlyUserDetails: CountlyUserDetailsAdapter {}
