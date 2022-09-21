
import UIKit

protocol DeleteAlertProtocol {
    func deleteActivity()
}

struct DeleteAlert {
    let delegate: DeleteAlertProtocol?

    func deleteActivity(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No".localized(), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes".localized(), style: .destructive, handler: { action in deleteActivityDelegate()
        }))
        viewController.present(alert, animated: true)
    }

    func deleteActivityDelegate() {
        delegate?.deleteActivity()
    }

    func focusOnActivityConfirm(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized(), style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
}
