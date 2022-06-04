
import UIKit
import CoreData

extension ActivityDetailedViewController {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        guard let cell = tableView.cellForRow(at: indexPath) as? ActivitiesTableViewCell else { return }

        let selectedIndexPath = tableView.indexPathForSelectedRow
        guard selectedIndexPath?.section != 0 || selectedIndexPath?.section != 1 || selectedIndexPath?.section != 3 || selectedIndexPath?.section != 4 else { return }

        if selectedIndexPath?.row == 1 {
            let titleRowEditAction = UIAlertController(title: "Edit Title", message: "Please edit the title", preferredStyle: .alert)
            titleRowEditAction.addTextField(configurationHandler: { (newTitle) -> Void in
                newTitle.text = self.activity.title
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })

            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in

                SelectedActivity.selectedActivity = self.activity

                self.activity.title = (titleRowEditAction.textFields?.first?.text)!

                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                if SelectedActivity.selectedActivity != nil {

                    do {
                        try context.save()
                        SelectedActivity.selectedActivity = nil
                    } catch {
                        print("Can't save the context")
                    }
                }

                tableView.reloadData()
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })

            titleRowEditAction.addAction(okayAction)
            titleRowEditAction.addAction(cancelAction)
            self.present(titleRowEditAction, animated: true, completion: nil)
        }

        // MARK: DESCRIPTION EDITING
        if selectedIndexPath?.row == 3 {
            let descRowEditAction = UIAlertController(title: "Edit Description", message: "Please edit the description", preferredStyle: .alert)
            descRowEditAction.addTextField(configurationHandler: { (newDescription) -> Void in
                newDescription.text = self.activity.desc
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })

            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in

                SelectedActivity.selectedActivity = self.activity
                self.activity.desc = (descRowEditAction.textFields?.first?.text)!

                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                if SelectedActivity.selectedActivity != nil {
                    do {
                        try context.save()
                        SelectedActivity.selectedActivity = nil
                    } catch {
                        print("Can't save the context")
                    }
                }

                tableView.reloadData()
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })

            descRowEditAction.addAction(okayAction)
            descRowEditAction.addAction(cancelAction)
            self.present(descRowEditAction, animated: true, completion: nil)
        }

        if selectedIndexPath?.row == 0 {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

            SelectedActivity.selectedActivity = self.activity

            if let selectedActivity = SelectedActivity.selectedActivity {

                if selectedActivity.fav {
                    selectedActivity.fav = false
                    print("\(selectedActivity) is now not marked favourite")
                } else {
                    selectedActivity.fav = true
                    print("\(selectedActivity) is now marked favourite")
                }

                do {
                    try context.save()
                    SelectedActivity.selectedActivity = nil
                } catch {
                    print("Can't save the context")
                }
            }
            tableView.reloadData()
        }

        if selectedIndexPath?.row == 4 {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

//            conformDeleteAlert.focusOnActivityConfirm(on: self, with: "Now \(activity.title ?? "your activity") is being focused", message: "You can return to Timer")

            SelectedActivity.selectedActivity = self.activity
            FocusedActivity.focusedActivityText = self.activity.title
            print("\(FocusedActivity.focusedActivityText)")

            if let selectedActivity = SelectedActivity.selectedActivity {

                FocusedActivity.focusedActivityText = selectedActivity.title

                navigationController?.pushViewController(newTimerScreen, animated: true)

                newTimerScreen.timerView.focusLabel.text = FocusedActivity.focusedActivityText
                newTimerScreen.timerView.focusLabel.textColor = sandyYellowColor


//                navigationController?.popToRootViewController(animated: true)
//                _ = navigationController?.popViewController(animated: true)
//                show(TimerViewController(), sender: self)
//                navigationController?.pushViewController(TimerViewController(), animated: true)

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
}
