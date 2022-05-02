
import UIKit
import CoreData

class NewActivityViewController: UIViewController, NewActivityViewActions, RemovableTextWithAlert {

    lazy var newActivityView = NewActivityView()
    lazy var conformAlert = Alert(delegate: self)
    lazy var activityTableViewController = ActivityTableViewController()

    lazy var newActivityTitle = String()
    lazy var newActivityDescription = String()

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

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
        let newActivity = Activity(entity: entity!, insertInto: context)
        newActivity.id = ActivityTableViewController.objects.count as NSNumber
        newActivity.title =  newActivityView.textField.text
        newActivity.desc = newActivityView.descriptionTextView.text
        newActivity.fav = false
        do {
            try context.save()
            ActivityTableViewController.objects.append(newActivity)
            show(activityTableViewController, sender: self)
        } catch {
            print("Can not save context")
        }
    }
}
