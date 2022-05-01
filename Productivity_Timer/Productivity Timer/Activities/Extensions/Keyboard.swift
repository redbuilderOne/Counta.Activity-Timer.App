
import UIKit

extension ActivitiesViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewActivityViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newActivityView.textField.resignFirstResponder()
        newActivityView.descriptionTextView.resignFirstResponder()
        return true
    }
}
