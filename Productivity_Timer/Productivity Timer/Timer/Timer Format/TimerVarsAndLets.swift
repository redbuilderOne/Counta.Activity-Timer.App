
import UIKit

struct LetsAndVarsForTimer {
    enum Keys: String {
        case START_TIME_KEY = "startTime"
        case STOP_TIME_KEY = "stopTime"
        case COUNTING_KEY = "countingKey"
        case SET_TIME_KEY = "setTime"
        case ROUND_ANIMATOR_KEY = "roundAnimatorKey"
        case SEC_TO_SAVE = "secondsToSave"
        case MIN_TO_SAVE = "minutesToSave"
        case HOURS_TO_SAVE = "hoursToSave"
    }

    var timer = Timer()
    var isTimerActivated = false
    var startTime: Date?
    var stopTime: Date?
    var countDownTime: Date?
    let userDefaults = UserDefaults.standard
    var scheduledTimer: Timer!
    var secondsToSave: Date?
    var minutesToSave: Date?
    var hoursToSave: Date?
}
