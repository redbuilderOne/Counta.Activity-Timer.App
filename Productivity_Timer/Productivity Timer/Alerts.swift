
import UIKit

struct Alert {

    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Alert Action 1
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))

        // Alert Action 2
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        // vc: UIViewController
        vc.present(alert, animated: true)
    }
}

