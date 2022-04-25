
import Foundation
import UIKit

// MARK: - Variables & Constants

struct LetsAndVarsForTimer {

    enum Keys: String {
        case START_TIME_KEY = "startTime"
        case STOP_TIME_KEY = "stopTime"
        case COUNTING_KEY = "countingKey"
        case SET_TIME_KEY = "setTime"
        case ROUND_ANIMATOR_KEY = "roundAnimatorKey"
    }
    
    var timer = Timer()
    var countdown = Float() // ?
    var isTimerActivated = false
    var startTime: Date?
    var stopTime: Date?
    var countDownTime: Date?
    let userDefaults = UserDefaults.standard
    var scheduledTimer: Timer!
}
