
import UIKit
import CoreData

class ActivityTableViewController: UITableViewController {

    var firstLoad = true

    lazy var identifier = CellsID.activityTableViewID
    lazy var newActivityVC = NewActivityViewController()
    var activityDetailedViewController: UITabBarController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
        setupNavigationBar()
        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: identifier)
        firstLoadCheck()
    }

    private func firstLoadCheck() {
        if firstLoad {
            firstLoad = false
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")

            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let activity = result as! Activity
                    ActivitiesObject.arrayOfActivities.append(activity)
                }
            } catch {
                print("Fetch failed")
            }
        }
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

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        view.backgroundColor = darkMoonColor
    }

    @objc func cellDidTapped() {
        if let activityDetailedViewController = activityDetailedViewController {
            present(activityDetailedViewController, animated: true)
        }
        tableView.reloadData()
    }

    static func nonDeletedActivities() -> [Activity] {
        var nonDeletedActivities = [Activity]()
        for activity in ActivitiesObject.arrayOfActivities {
            if activity.deletedDate == nil {
                nonDeletedActivities.append(activity)
            }
        }
        return nonDeletedActivities
    }
}
