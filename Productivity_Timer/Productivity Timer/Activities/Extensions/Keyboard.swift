
import UIKit

extension NewActivityViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newActivityView?.textField.resignFirstResponder()
        return true
    }
}
