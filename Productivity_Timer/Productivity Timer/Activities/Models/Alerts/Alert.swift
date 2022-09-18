
import UIKit

protocol RemovableTextWithAlert {
    func removeText()
}

struct Alert {
    let delegate: RemovableTextWithAlert?

    var timer: Timer?

    func textClearAlert(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in removeFunction()
        }))
        viewController.present(alert, animated: true)
    }

    func removeFunction() {
        delegate?.removeText()
    }

    func isEmptyTextFields(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc.present(alert, animated: true)
    }
}
