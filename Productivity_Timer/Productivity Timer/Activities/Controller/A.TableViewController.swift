
import UIKit
import CoreData

class ActivityTableViewController: UITableViewController {
    lazy var identifier = CellsID.activityTableViewID
    var activityDetailedViewController: UITabBarController?
    var actionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
        setupNavigationBar()

        let firstLoadCheck = FirstLoadCheck()
        firstLoadCheck.actionHandler = { [weak firstLoadCheck] in
            print("firstLoadCheck - \(String(describing: firstLoadCheck))")
        }

        firstLoadCheck.firstLoadCheckTableVC()
        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        view.backgroundColor = darkMoonColor
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
        let newActivityVC = NewActivityViewController()
            newActivityVC.actionHandler = { [weak newActivityVC] in
                newActivityVC?.dismiss(animated: true, completion: nil)
          }
        show(newActivityVC, sender: self)
    }

    @objc func cellDidTapped() {
        if let activityDetailedViewController = activityDetailedViewController {
            present(activityDetailedViewController, animated: true)
        }
        tableView.reloadData()
    }
}
