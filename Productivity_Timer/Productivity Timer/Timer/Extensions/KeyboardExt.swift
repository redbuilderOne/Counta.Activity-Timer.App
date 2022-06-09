
import UIKit

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(userText: UITextField) -> Bool {

        focusTextLabelDidTapped = true
//        focusActivityCheck()

//        timerView.focusLabel.text = FocusedActivity.focusedActivityText
        timerView.focusLabel.textColor = sandyYellowColor
        timerView.focusLabel.layer.opacity = 1

//        timerView.focusTextField.text = FocusedActivity.focusedActivityText
            return true
        }

    @objc func focusTextFieldAction(_ textField: UITextField) -> String {
        let newTextTyped = timerView.focusTextField.text
        if let newTextTyped = newTextTyped {
            focusCurrentText = newTextTyped
        } else {
            print("Error the textField is empty")
        }
        timerView.focusLabel.text = focusCurrentText
        return focusCurrentText
    }
}
