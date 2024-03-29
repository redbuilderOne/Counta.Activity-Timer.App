
import UIKit
import CoreData

class FocusRowEditAlert {
    var timerViewController: TimerViewController?

    func focusRowEditAction(on viewController: UIViewController, activity: Activity, tableView: UITableView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        timerViewController = TimerViewController(activity: activity)

        SelectedActivity.shared.activity = activity
        print("Now Focused Activity is \(activity.title ?? "")")
        
        for activities in ActivitiesObject.arrayOfActivities {
            activities.isFocused = false
            print("Activity (\(activities.title ?? "")) is NOT focused EXCEPT \(activity.title ?? "")")
        }
        
        activity.isFocused = true
        
        if activity.isFocused {
            SelectedActivity.shared.activity = activity
        }
        
        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        timerViewController?.timerView.stopButtonPressed()
    }
    
    func cancelFocusRowEditAction(on vc: UIViewController, activity: Activity, tableView: UITableView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        SelectedActivity.shared.activity = activity
        print("Now Focused Activity is \(activity.title ?? "")")
        
        for activities in ActivitiesObject.arrayOfActivities {
            activities.isFocused = false
            print("Activity (\(activities.title ?? "")) is NOT focused EXCEPT \(activity.title ?? "")")
        }
        
        activity.isFocused = false
        
        timerViewController?.timerView.focusTextField.isHidden = false
        timerViewController?.timerView.focusLabel.isHidden = false
        timerViewController?.timerView.focusLabel.text = "tap to focus on activity".localized()
        timerViewController?.timerView.focusLabel.textColor = .systemGray
        timerViewController?.timerView.focusLabel.layer.opacity = 0.3
        
        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        timerViewController?.timerView.stopButtonPressed()
    }
}
