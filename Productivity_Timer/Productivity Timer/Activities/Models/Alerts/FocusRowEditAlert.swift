
import UIKit
import CoreData

struct FocusRowEditAlert {
    func focusRowEditAction(on vc: UIViewController, activity: Activity, tableView: UITableView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        SelectedActivity.selectedActivity = activity
        FocusedActivityToPresent.focusedActivity = activity
        print("Now Focused Activity is \(activity.title ?? "")")
        
        for activities in ActivitiesObject.arrayOfActivities {
            activities.isFocused = false
            print("Activity (\(activities.title ?? "")) is NOT focused EXCEPT \(activity.title ?? "")")
        }
        
        activity.isFocused = true
        
        if activity.isFocused {
            TimerViewControllerStruct.timerViewController.timerView.focusTextField.isHidden = true
            TimerViewControllerStruct.timerViewController.timerView.focusLabel.text = activity.focusedActivityTitle
            TimerViewControllerStruct.timerViewController.timerView.focusLabel.textColor = sandyYellowColor
            TimerViewControllerStruct.timerViewController.timerView.focusLabel.layer.opacity = 1
            TimerViewControllerStruct.timerViewController.timerView.stopButtonPressed()
        }
        
        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
        
        SelectedActivity.selectedActivity = nil
        
        tableView.reloadData()
        TimerViewControllerStruct.timerViewController.timerView.stopButtonPressed()
    }
    
    func cancelFocusRowEditAction(on vc: UIViewController, activity: Activity, tableView: UITableView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        SelectedActivity.selectedActivity = activity
        FocusedActivityToPresent.focusedActivity = activity
        print("Now Focused Activity is \(activity.title ?? "")")
        
        for activities in ActivitiesObject.arrayOfActivities {
            activities.isFocused = false
            print("Activity (\(activities.title ?? "")) is NOT focused EXCEPT \(activity.title ?? "")")
        }
        
        activity.isFocused = false
        
        TimerViewControllerStruct.timerViewController.timerView.focusTextField.isHidden = false
        TimerViewControllerStruct.timerViewController.timerView.focusLabel.isHidden = false
        TimerViewControllerStruct.timerViewController.timerView.focusLabel.text = "tap to focus on activity"
        TimerViewControllerStruct.timerViewController.timerView.focusLabel.textColor = .systemGray
        TimerViewControllerStruct.timerViewController.timerView.focusLabel.layer.opacity = 0.3
        
        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
        
        SelectedActivity.selectedActivity = nil
        
        tableView.reloadData()
        TimerViewControllerStruct.timerViewController.timerView.stopButtonPressed()
    }
}
