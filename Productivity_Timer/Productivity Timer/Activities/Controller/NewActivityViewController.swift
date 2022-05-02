
import UIKit

class NewActivityViewController: UIViewController, NewActivityViewActions, RemovableTextWithAlert {

    lazy var newActivityView = NewActivityView()
    lazy var conformAlert = Alert(delegate: self)
    lazy var activityTableViewController = ActivityTableViewController()

    override func loadView() {
        view = newActivityView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newActivityView.delegate = self
        configureView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureView()
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        view.backgroundColor = darkMoonColor
    }

    //MARK: - Buttons actions
    func clearButtonDidPressed() {
        conformAlert.textClearAlert(on: self, with: "Are you sure?", message: "This will delete all the text")
    }

    func removeText() {
        newActivityView.textField.text = ""
        newActivityView.descriptionTextView.text = ""
    }

    func okButtonDidPressed() {
        show(activityTableViewController, sender: self)
    }
}
