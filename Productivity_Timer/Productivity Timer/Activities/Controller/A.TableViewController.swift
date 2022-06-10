
import UIKit
import CoreData

class ActivityTableViewController: UITableViewController {

    var firstLoad = true

    lazy var identifier = CellsID.activityTableViewID
    lazy var newActivityVC = NewActivityViewController()
    var activityDetailedViewController: UITabBarController?

    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToDownSwipeGesture))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
        setupNavigationBar()
        firstLoadCheck()
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
                    if activity.isDone != true {
                        ActivitiesObject.arrayOfActivities.append(activity)
                    } else {
                        DoneActivities.doneActivitiesArray.append(activity)
                    }
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

    @objc func cellDidTapped() {
        if let activityDetailedViewController = activityDetailedViewController {
            present(activityDetailedViewController, animated: true)
        }
        tableView.reloadData()
    }
}
