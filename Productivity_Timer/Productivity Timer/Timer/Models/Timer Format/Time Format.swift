
import UIKit

class TimerFormat {
    func setSecondsToHoursMinutesToHours(_ miliseconds: Int) -> (Int, Int, Int) {
        let hour = miliseconds / 3600
        let min = (miliseconds % 3600) / 60
        let sec = (miliseconds % 3600) % 60
        return (hour, min, sec)
    }

    func convertTimeToString(hour: Int? = nil, min: Int? = nil, sec: Int? = nil) -> String {
        var timeString = ""

        if let hour = hour {
            timeString += String(format: "%02d", hour)
        }

        timeString += ":"

        if let min = min {
            timeString += String(format: "%02d", min)
        }

        timeString += ":"

        if let sec = sec {
            timeString += String(format: "%02d", sec)
        }

        return timeString
    }
}
