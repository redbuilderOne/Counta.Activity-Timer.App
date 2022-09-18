
import UIKit

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        useAndDeleteCoreDataSaver(isViewAffected: true)
        return false
    }
}
