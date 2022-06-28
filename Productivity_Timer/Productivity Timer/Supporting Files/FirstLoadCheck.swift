
import UIKit
import CoreData

struct FirstLoadCheck {
    var firstLoad = true

    mutating func firstLoadCheckTimerVC() {
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
                        FocusedActivityToPresent.focusedActivity = activity
                        TimerViewControllerStruct.timerViewController.timerView.focusLabel.text = activity.title
                        TimerViewControllerStruct.timerViewController.timerView.focusLabel.textColor = sandyYellowColor
                        TimerViewControllerStruct.timerViewController.timerView.focusLabel.layer.opacity = 1
                        TimerViewControllerStruct.timerViewController.timerView.focusTextField.isHidden = true
                        TimerViewControllerStruct.timerViewController.setButtonImg(title: " Play", img: "play")
                    } else {
                        TimerViewControllerStruct.timerViewController.setButtonImg(title: " Pause", img: "pause")
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }
    }

    mutating func firstLoadCheckTableVC() {
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

    mutating func firstLoadCheckTimeSpent() {
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
}
