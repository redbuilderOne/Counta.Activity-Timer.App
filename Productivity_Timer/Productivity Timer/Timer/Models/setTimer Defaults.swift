
import Foundation

final class SetTimerSettings {
    
    static var setTimerValue: Int? {
        get {
            return UserDefaults.standard.integer(forKey: LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue
            if let timeValue = newValue {
                defaults.set(timeValue, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
