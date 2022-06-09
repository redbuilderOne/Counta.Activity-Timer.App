
import UIKit
import CoreData

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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        focusTextLabelDidTapped = true
        focusActivityCheck()
//        timerView.focusLabel.isHidden = false
//        timerView.focusTextField.isHidden = true
        return false
    }

}
