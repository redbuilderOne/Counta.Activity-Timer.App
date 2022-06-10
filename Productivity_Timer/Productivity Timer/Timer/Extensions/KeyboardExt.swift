
import UIKit
import CoreData

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        saveFocusActivityToCoreData()
        return false
    }
}
