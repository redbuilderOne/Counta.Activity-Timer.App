
import UIKit

extension TimerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return secFormat.secondsArray.count
    }
}

extension TimerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(secFormat.secondsArray[row]) + " sec"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timerView.timerLabel.isHidden = false
        timerView.startButton.isEnabled = false

        constants.countdown = secFormat.secondsArray[row]

        timerView.timerLabel.text = "SET"
        timerView.timerLabel.textColor = .systemGreen
        startTimer(timeInterval: 1, action: #selector(beginCountDown))
    }
}

