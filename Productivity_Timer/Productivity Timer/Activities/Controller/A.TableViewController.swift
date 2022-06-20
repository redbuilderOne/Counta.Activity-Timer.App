
import UIKit
import CoreData

class ActivityTableViewController: UITableViewController {
    lazy var firstLoadCheck = FirstLoadCheck()
    lazy var identifier = CellsID.activityTableViewID
    lazy var newActivityVC = NewActivityViewController()
    var activityDetailedViewController: UITabBarController?

    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToDownSwipeGesture))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
        setupNavigationBar()
        firstLoadCheck.firstLoadCheckTableVC()
        configureTableView()

        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        view.backgroundColor = darkMoonColor
    }

    @objc func respondToDownSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                show(newActivityVC, sender: self)
            default:
                break
            }
        }
    }

    private func configureTableView() {
        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 40
        tableView.estimatedRowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupNavigationBar() {
        self.title = "Activities"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = sandyYellowColor
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action:  #selector(addNewActivity))
        self.navigationItem.rightBarButtonItem = addItem
        self.navigationItem.rightBarButtonItem?.tintColor = sandyYellowColor
    }

    @objc func addNewActivity() {
        show(newActivityVC, sender: self)
    }

    @objc func cellDidTapped() {
        if let activityDetailedViewController = activityDetailedViewController {
            present(activityDetailedViewController, animated: true)
        }
        tableView.reloadData()
    }
}
