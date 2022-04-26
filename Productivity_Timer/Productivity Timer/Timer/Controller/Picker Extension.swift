
import UIKit

extension TimerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hourFormat.hoursArray.count
        } else if component == 1 {
            return minFormat.minutesArray.count
        } else {
            return secFormat.secondsArray.count
        }
    }
}

extension TimerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(hourFormat.hoursArray[row]) + " h"
        } else if component == 1 {
            return String(minFormat.minutesArray[row]) + " min"
        } else {
            return String(secFormat.secondsArray[row]) + " s"
        }

//        return String(minFormat.minutesArray[row]) + " min"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        timerView.timerLabel.isHidden = false
        timerView.startButton.isEnabled = false
        constants.countdown = Int(minFormat.minutesArray[row])
        print("\(constants.countdown)")

        SetTimerSettings.setTimerValue = minFormat.minutesArray[row]
        print("\(String(describing: SetTimerSettings.setTimerValue))")

        timerView.timerLabel.text = "SET"

//        let setCdTimer = timerFormat.setSecondsToHoursMinutesToHours(pickerFormatArray[row] * 60)
//
//        print("\(setCdTimer)")
//
//        constants.setCdTimerString = timerFormat.convertTimeToString(hour: setCdTimer.0, min: setCdTimer.1, sec: setCdTimer.2)
//        timerView.timerLabel.text = constants.setCdTimerString

        startTimer(timeInterval: 0.1, action: #selector(beginCountDown))
        
    }
}

