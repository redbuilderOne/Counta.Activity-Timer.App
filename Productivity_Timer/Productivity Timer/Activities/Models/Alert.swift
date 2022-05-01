
import UIKit

struct Alert {

    func textClearAlert(on vc: UIViewController, with title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in

        }))

        vc.present(alert, animated: true)
    }
}

