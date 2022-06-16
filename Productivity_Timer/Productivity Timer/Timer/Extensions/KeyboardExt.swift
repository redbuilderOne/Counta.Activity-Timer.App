
import UIKit
import CoreData

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        saveFocusActivityToCoreData()
        timerView.focusLabel.isHidden = false
//      timerView.focusLabel.isUserInteractionEnabled = false
        return false
    }
}
