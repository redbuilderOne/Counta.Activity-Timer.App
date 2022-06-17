
import UIKit
import CoreData

struct FocusRowEditAlert {
    func focusRowEditAction(on vc: UIViewController, activity: Activity, tableView: UITableView) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        SelectedActivity.selectedActivity = activity
        FocusedActivity.activity = activity
        FocusedActivity.focusedActivityText = activity.title
        print("\(FocusedActivity.focusedActivityText ?? "")")
        print("Now Focused Activity is \(activity.title ?? "")")

        if let selectedActivity = SelectedActivity.selectedActivity {
            FocusedActivity.focusedActivityText = selectedActivity.title
            activity.focusedActivityTitle = FocusedActivity.focusedActivityText ?? ""
            activity.isFocused = true

            if activity.isFocused {
                TimerViewControllerStruct.timerViewController.timerView.focusLabel.text = activity.focusedActivityTitle
                TimerViewControllerStruct.timerViewController.timerView.focusLabel.textColor = sandyYellowColor
                TimerViewControllerStruct.timerViewController.timerView.focusLabel.layer.opacity = 1
            }

            do {
                try context.save()

            } catch {
                print("Can't save the context")
            }
            SelectedActivity.selectedActivity = nil
        }
        
        tableView.reloadData()
    }
}
