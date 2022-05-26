
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
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: ПЕРЕМЕЩЕНИЕ
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

        SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[sourceIndexPath.row]

        let moved = ActivitiesObject.arrayOfActivities.remove(at: sourceIndexPath.row)
        ActivitiesObject.arrayOfActivities.insert(moved, at: destinationIndexPath.row)
        tableView.reloadData()

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
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }

    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")

        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {

                let activity = result as! Activity

                for _ in ActivitiesObject.arrayOfActivities {
                    activity.deletedDate = Date()
                }

                //                activity.deletedDate = Date()
                try context.save()
            }
        } catch {
            print("Fetch failed")
        }

        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            ActivitiesObject.arrayOfActivities.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)

            // TODO: coreData access
            ActivitiesObject.arrayOfActivities.remove(at: indexPath.row)
            print(ActivitiesObject.arrayOfActivities)
            self.tableView.reloadData()
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }

    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let object = ActivitiesObject.arrayOfActivities[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.fav = !object.fav
            ActivitiesObject.arrayOfActivities[indexPath.row] = object
            completion(true)
        }

        action.backgroundColor = object.fav ? .systemPurple : .systemGray
        action.image = object.fav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        if object.fav {
            object.fav = true
        } else {
            object.fav = false
        }
        return action
    }
}
