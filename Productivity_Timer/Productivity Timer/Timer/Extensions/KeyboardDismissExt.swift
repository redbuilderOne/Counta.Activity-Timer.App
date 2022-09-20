
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround(textToClear: UILabel? = nil) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        if let textToClear = textToClear {
            textToClear.text = "tap to focus on activity".localized()
            view.setNeedsDisplay()
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
