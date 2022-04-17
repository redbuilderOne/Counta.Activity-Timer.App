
import UIKit

class TimerFormat {

    static func setSecondsToHoursMinutesToHours(_ miliseconds: Int) -> (Int, Int, Int) {
        let hour = miliseconds / 3600
        let min = (miliseconds % 3600) / 60
        let sec = (miliseconds % 3600) % 60
        return (hour, min, sec)
    }

    static func convertTimeToString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }

}

