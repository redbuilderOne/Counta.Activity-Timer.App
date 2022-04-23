
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
        print("isTimerSet = \(constants.isTimerSet)")
        startTimer(action: #selector(beginCountDown))
        timerView.timerLabel.isHidden = false
        timerView.startButton.isEnabled = false
        constants.countdown = pickerFormatArray[row]
        

     
//        constants.countDownTime = 
//        setStartTime(date: )
//        setCountDownTimer(date: )


//        let time = timerFormat.setSecondsToHoursMinutesToHours(SetTimerSettings.setTimerValue ?? 0)
//        let timeString = timerFormat.convertTimeToString(hour: 0, min: time.2, sec: 0)

//        if pickerFormatArray[row] != pickerFormatArray[11] {
//            timerView.timerLabel.text = timeString
//        } else if pickerFormatArray[row] == pickerFormatArray[0] {
//            timerView.timerLabel.text = timeString
//        } else {
//            timerView.timerLabel.text = timeString
//        }

        SetTimerSettings.setTimerValue = pickerFormatArray[row]
        print("\(String(describing: SetTimerSettings.setTimerValue))")
        timerView.timerLabel.text = String(pickerFormatArray[row])

        constants.userDefaults.set(constants.startTime, forKey: LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue)

//        let timeString = timerFormat.convertTimeToString(min: time.2)
    }
}

