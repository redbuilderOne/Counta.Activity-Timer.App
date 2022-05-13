
import UIKit
import CoreData

extension ActivityTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActivityTableViewController.nonDeletedActivities().count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(ActivityDetailedViewController(activity: ActivityTableViewController.nonDeletedActivities()[indexPath.row]), animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ActivitiesTableViewCell else { fatalError() }
        let object = ActivityTableViewController.nonDeletedActivities()[indexPath.row]
        cell.set(object: object)
        cell.backgroundColor = blueMoonlight
        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {

                let activity = result as! Activity

                if editingStyle == .delete {
                    activity.deletedDate = Date()
                    try context.save()
                }
            }

        } catch {
            print("Fetch failed")
        }

        if editingStyle == .delete {
            do {
                try context.save()
                ActivitiesObject.arrayOfActivities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

            } catch {
                print("Can't save the context")
            }
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = ActivitiesObject.arrayOfActivities.remove(at: sourceIndexPath.row)
        ActivitiesObject.arrayOfActivities.insert(moved, at: destinationIndexPath.row)
        tableView.reloadData()
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
                activity.deletedDate = Date()
                try context.save()
            }

        } catch {
            print("Fetch failed")
        }

        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            ActivitiesObject.arrayOfActivities.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
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
