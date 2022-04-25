
import UIKit

extension TimerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerFormatArray.count
    }
}

extension TimerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerFormatArray[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        startTimer(timeInterval: 1, action: #selector(beginCountDown))
        timerView.timerLabel.isHidden = false
        timerView.startButton.isEnabled = false
        constants.countdown = Float(pickerFormatArray[row])


        SetTimerSettings.setTimerValue = pickerFormatArray[row]
        print("\(String(describing: SetTimerSettings.setTimerValue))")
        timerView.timerLabel.text = String(pickerFormatArray[row])

        constants.userDefaults.set(constants.startTime, forKey: LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue)


//        timerFormat.convertTimeToString(hour: 0, min: pickerFormatArray[row], sec: 0)
//        setSecondsToHoursMinutesToHours()

        let setCdTimer = timerFormat.setSecondsToHoursMinutesToHours(pickerFormatArray[row] * 60)

        print("\(setCdTimer)")

        let setCdTimerString = timerFormat.convertTimeToString(hour: setCdTimer.0, min: setCdTimer.1, sec: setCdTimer.2)

        timerView.timerLabel.text = setCdTimerString
    }
}

