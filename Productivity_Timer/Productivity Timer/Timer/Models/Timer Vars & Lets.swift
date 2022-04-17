
import Foundation

// MARK: - Variables & Constants
var timer = Timer()
var runCount = 0
var durationCounter = 0
var countdown = 0
var isTimerActivated = false
var startTime: Date?
var stopTime: Date?
let userDefaults = UserDefaults.standard
let START_TIME_KEY = "startTime"
let STOP_TIME_KEY = "stopTime"
let COUNTING_KEY = "countingKey"
var scheduledTimer: Timer!
