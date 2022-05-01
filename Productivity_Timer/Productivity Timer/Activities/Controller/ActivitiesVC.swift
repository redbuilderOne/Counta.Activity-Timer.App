
import UIKit

final class ActivitiesViewController: UIViewController, ActivitiesViewDelegate {

    var activitiesView = ActivitiesView()
    let newActivityView = NewActivityViewController()

    override func loadView() {
        view = activitiesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activitiesView.delegate = self
        configureView()
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        view.backgroundColor = darkMoonColor
    }

    // MARK: - Actions
    func plusButtonDidPressed() {
//      activitiesView.plusButton.isHidden = true
//      activitiesView.tableView.isHidden = false
        show(newActivityView, sender: self)
        print("plusButton is pressed")
    }
}
