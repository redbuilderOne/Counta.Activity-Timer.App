
import UIKit

class TimerFormat {
    func formatTimeSpent(_ time: [Int]?) -> (Int, Int, Int) {
        if let time = time {
            let time0 = Int(time[0])
            let time1 = Int(time[1])
            let time2 = Int(time[2])
            return (time0, time1, time2)
        }
        return (0, 0, 0)
    }

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

    func converter(_ mil: Int) -> [Int] {
        let miliseconds = mil

        let days = miliseconds / 86400
        let hours = miliseconds % 86400 / 3600
        let minutes = miliseconds % 3600 / 60
        let seconds = miliseconds % 3600 % 60

        print(String((miliseconds / 86400)) + " days")
        print(String((miliseconds % 86400) / 3600) + " hours")
        print(String((miliseconds % 3600) / 60) + " minutes")
        print(String((miliseconds % 3600) % 60) + " seconds")
        return [days, hours, minutes, seconds]
    }
}
