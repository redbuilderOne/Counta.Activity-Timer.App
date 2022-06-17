
import UIKit
import CoreData

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        saveFocusActivityToCoreData()
        timerView.focusLabel.isHidden = false
        timerView.stopButtonPressed()
        timerView.timerLabel.text = "FOCUSED"
        timerView.timerLabel.textColor = pinkyWhiteColor
//      timerView.focusLabel.isUserInteractionEnabled = false
        return false
    }
}
