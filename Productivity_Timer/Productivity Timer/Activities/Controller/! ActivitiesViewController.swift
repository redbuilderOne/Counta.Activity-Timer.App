
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureView()
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        view.backgroundColor = darkMoonColor
    }

    // MARK: - Actions
    func plusButtonDidPressed() {
        show(newActivityView, sender: self)
    }
}
