
import UIKit
import CoreData

class FirstLoadCheck {
    var firstLoad = true
    let timerViewController: TimerViewController?
    var coreDataSaver: CoreDataSaver?

    init(activity: Activity? = nil) {
        timerViewController = TimerViewController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func firstLoadCheck() {
        if firstLoad {
            firstLoad = false
            coreDataSaver = CoreDataSaver()
            let context = coreDataSaver!.loadPersistentContainer()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")

            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let activity = result as! Activity
                    if activity.isFocused {
                        SelectedActivity.shared.activity = activity
                        SelectedActivity.shared.selectedIndexToDelete = activity.id as? Int
                    }

                    if activity.isDone != true {
                        ActivitiesObject.arrayOfActivities.append(activity)
                    } else {
                        DoneActivities.doneActivitiesArray.append(activity)
                    }
                }
            } catch {
                print("Fetch failed")
            }
            coreDataSaver = nil
        }
    }

    func firstLoadCheckTableVC() {
        if firstLoad {
            firstLoad = false
            coreDataSaver = CoreDataSaver()
            let context = coreDataSaver!.loadPersistentContainer()
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
            coreDataSaver = nil
        }
    }

    func firstLoadCheckTimeSpent() {
        if firstLoad {
            firstLoad = false
            coreDataSaver = CoreDataSaver()
            let context = coreDataSaver!.loadPersistentContainer()
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
            coreDataSaver = nil
        }
    }
}
