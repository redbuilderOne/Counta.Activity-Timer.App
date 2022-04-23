
import Foundation

// MARK: - Variables & Constants

struct LetsAndVarsForTimer {

    enum Keys: String {
        case START_TIME_KEY = "startTime"
        case STOP_TIME_KEY = "stopTime"
        case COUNTING_KEY = "countingKey"
        case SET_TIME_KEY = "setTime"
    }
    
    var timer = Timer()
    var runCount = 0
    var durationCounter = 0
    var countdown = 0
    var isTimerActivated = false
    var isTimerSet = false
    var startTime: Date?
    var stopTime: Date?
    var countDownTime: Date?
    let userDefaults = UserDefaults.standard
    var scheduledTimer: Timer!
}
