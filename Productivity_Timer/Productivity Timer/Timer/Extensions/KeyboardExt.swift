
import UIKit
import CoreData

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        focusTextLabelDidTapped = true
        focusActivityCheck()
        saveFocusActivityToCoreData()
        return false
    }
}
