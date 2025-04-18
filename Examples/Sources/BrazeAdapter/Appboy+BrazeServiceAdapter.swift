import class AppboyKit.Appboy
import protocol Tracker.BrazeServiceAdapter

extension Appboy: BrazeServiceAdapter {
    public func setCustomAttributeWithKey(_ key: String, andStringValue value: String) {
        Appboy.sharedInstance()?.user.setCustomAttributeWithKey(key, andStringValue: value)
    }

    public func unsetCustomAttributeWithKey(_ key: String) {
        Appboy.sharedInstance()?.user.unsetCustomAttribute(withKey: key)
    }
}
