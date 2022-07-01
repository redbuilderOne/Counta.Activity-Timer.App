
import UIKit
import CoreData

class NewActivityViewController: UIViewController, NewActivityViewActions, RemovableTextWithAlert {
    let newActivityView: CreateNewActivityView?
    lazy var conformAlert = Alert(delegate: self)
    lazy var activity = Activity()
    var actionHandler: (() -> Void)?

    override func loadView() {
        view = newActivityView
    }

    init() {
        newActivityView = CreateNewActivityView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Activity"
        newActivityView?.delegate = self
        newActivityView?.textField.delegate = self
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

    @objc func saveData() {
        if newActivityView?.textField.text == "" {
            conformAlert.isEmptyTextFields(on: self, with: "Nah", message: "The text field can't be empty")
            return

        } else {
            var duplicateIndex: Int?
            duplicateIndex = ActivitiesObject.arrayOfActivities.firstIndex(where: { $0.title == newActivityView?.textField.text})

            print("Found duplicate index: \(String(describing: duplicateIndex))")

            if duplicateIndex != nil {
                duplicateIndex = nil
                conformAlert.isEmptyTextFields(on: self, with: "Sorry", message: "Activity already exists")
                print("Index \(String(describing: duplicateIndex)) cleared")
                return
                
            } else {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
                let newActivity = Activity(entity: entity!, insertInto: context)
                newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
                newActivity.title = newActivityView?.textField.text
                newActivity.desc = newActivityView?.descriptionTextView.text
                newActivity.fav = false
                newActivity.isDone = false
                newActivity.isFocused = false
                print("New Activity \(newActivity.title ?? "") is created at \(Date())")
                
                do {
                    try context.save()
                    ActivitiesObject.arrayOfActivities.append(newActivity)
                } catch {
                    print("Can't save the context")
                }
            }
        }
    }

    //MARK: - Buttons actions
    func clearButtonDidPressed() {
        if newActivityView?.textField.text == "" {
            conformAlert.isEmptyTextFields(on: self, with: "Oops", message: "Nothing to clear")
            return
        }
        conformAlert.textClearAlert(on: self, with: "Are you sure?", message: "This will delete all the text")
    }

    func removeText() {
        newActivityView?.textField.text = ""
        newActivityView?.descriptionTextView.text = ""
    }

    func okButtonDidPressed() {
        saveData()
        navigationController?.popViewController(animated: true)
    }
}

