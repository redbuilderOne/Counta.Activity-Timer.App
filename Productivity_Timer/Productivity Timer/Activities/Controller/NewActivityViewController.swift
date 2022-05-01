
import UIKit

class NewActivityViewController: UIViewController, NewActivityViewActions {

    lazy var newActivityView = NewActivityView()
    lazy var conformAlert = Alert()

    override func loadView() {
        view = newActivityView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newActivityView.delegate = self
        configureView()
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        view.backgroundColor = darkMoonColor
    }

    func clearButtonDidPressed() {
        conformAlert.textClearAlert(on: self, with: "Are you sure?", message: "This will delete all the text")


//        newActivityView.textField.text = ""
//        newActivityView.descriptionTextView.text = ""
        
        print("clearButton is pressed")
    }

    func okButtonDidPressed() {
        print("okButton is pressed")
    }
}
