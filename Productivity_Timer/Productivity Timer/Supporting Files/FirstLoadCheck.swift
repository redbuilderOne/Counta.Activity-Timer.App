
import UIKit
import CoreData

class FirstLoadCheck {
    var firstLoad = true
    var actionHandler: (() -> Void)?
    var activity: Activity
    let timerViewController: TimerViewController?

    init(activity: Activity? = nil) {
        self.activity = Activity()
        timerViewController = TimerViewController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func firstLoadCheckTimerVC() {
        if firstLoad {
            firstLoad = false
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")

            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let activity = result as! Activity
                    if activity.isFocused {

                        StaticSelectedActivity.activity = activity

//                        FocusedActivityToPresent.focusedActivity = activity
//                        timerViewController?.timerView.focusLabel.text = activity.title
//                        timerViewController?.timerView.focusLabel.textColor = sandyYellowColor
//                        timerViewController?.timerView.focusLabel.layer.opacity = 1
//                        timerViewController?.timerView.focusTextField.isHidden = true
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }
    }

    func firstLoadCheckTableVC() {
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

    func firstLoadCheckTimeSpent() {
        if firstLoad {
            firstLoad = false
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray

                let firstLoadCheck = FirstLoadCheck()
                firstLoadCheck.actionHandler = { [weak firstLoadCheck] in
                    print("firstLoadCheck - \(String(describing: firstLoadCheck))")
                }

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
}
