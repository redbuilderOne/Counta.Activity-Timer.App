
import UIKit


protocol DeleteAlertProtocol {
    func deleteActivity()
}

struct DeleteAlert {
    let delegate: DeleteAlertProtocol?

    func deleteActivity(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in deleteActivityDelegate()
        }))

        vc.present(alert, animated: true)
    }

    func deleteActivityDelegate() {
        delegate?.deleteActivity()
    }

    func focusOnActivityConfirm(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        vc.present(alert, animated: true)
    }
}
