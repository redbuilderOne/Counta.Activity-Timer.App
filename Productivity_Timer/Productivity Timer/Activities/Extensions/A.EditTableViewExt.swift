
import UIKit
import CoreData

extension ActivityTableViewController {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    //MARK: УДАЛЕНИЕ
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

            SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[indexPath.row]
            ActivitiesObject.arrayOfActivities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                if let selectedActivity = SelectedActivity.selectedActivity {
                    appDelegate.persistentContainer.viewContext.delete(selectedActivity)
                    selectedActivity.deletedDate = Date()
                }
                try appDelegate.persistentContainer.viewContext.save()

            } catch {
                print("Fetch failed")
            }

            SelectedActivity.selectedActivity = nil
            FocusedActivityToPresent.focusedActivity = nil
            
            tableView.reloadData()

            timerViewController?.timerView.focusTextField.isHidden = false
            timerViewController?.timerView.focusTextField.text = ""
            timerViewController?.timerView.focusLabel.isHidden = false
            timerViewController?.timerView.focusLabel.text = "tap to focus on activity"
            timerViewController?.timerView.focusLabel.textColor = .systemGray
            timerViewController?.timerView.focusLabel.layer.opacity = 0.1
            timerViewController?.stopTimer()
            timerViewController?.stopActionDidPressed()
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: ПЕРЕМЕЩЕНИЕ
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        // TODO: moving elements' order in coreData
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

        SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[sourceIndexPath.row]

        let moved = ActivitiesObject.arrayOfActivities.remove(at: sourceIndexPath.row)
        ActivitiesObject.arrayOfActivities.insert(moved, at: destinationIndexPath.row)
        tableView.reloadData()

//        do {
//            if let selectedActivity = SelectedActivity.selectedActivity {
//            appDelegate.persistentContainer.viewContext.delete(selectedActivity)
//            ActivitiesObject.arrayOfActivities.append(selectedActivity)
//                tableView.reloadData()
//               appDelegate.persistentContainer.viewContext.delete(selectedActivity)
//            }
//            try appDelegate.persistentContainer.viewContext.save()
//        } catch {
//            print("Fetch failed")
//        }

        SelectedActivity.selectedActivity = nil
    }

    // MARK: FAVOURITE
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }

    // MARK: DONE ACTION
    // TODO: поменять вместо DONE на MARK - чтобы отправлять на первый экран с таймером? ИЛИ добавить новый action "FOCUS"
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

        SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[indexPath.row]

        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in

            ActivitiesObject.arrayOfActivities.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)

            do {
                if let selectedActivity = SelectedActivity.selectedActivity {
                    selectedActivity.isDone = true
                    print("\(selectedActivity.title ?? "") is marked done and sent to doneActivitiesArray")
                }
                try appDelegate.persistentContainer.viewContext.save()

            } catch {
                print("Fetch failed")
            }

            completion(true)
            self.tableView.reloadData()
        }

        FocusedActivityToPresent.focusedActivity = nil
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }

    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

        let object = ActivitiesObject.arrayOfActivities[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.fav = !object.fav
            ActivitiesObject.arrayOfActivities[indexPath.row] = object
            completion(true)
        }

        SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[indexPath.row]

        action.backgroundColor = object.fav ? .systemPurple : .systemGray
        action.image = object.fav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")

        if object.fav {
            object.fav = true

            do {
                if let selectedActivity = SelectedActivity.selectedActivity {
                    selectedActivity.fav = true
                    print("\(selectedActivity.title ?? "") is marked Favourite")
                }
                try appDelegate.persistentContainer.viewContext.save()
            } catch {
                print("Fetch failed")
            }

        } else {
            object.fav = false

            do {
                if let selectedActivity = SelectedActivity.selectedActivity {
                    selectedActivity.fav = false
                    print("\(selectedActivity.title ?? "") is not marked Favourite")
                }
                try appDelegate.persistentContainer.viewContext.save()

            } catch {
                print("Fetch failed")
            }
        }
        return action
    }
}
