
import UIKit
import CoreData

struct FavRowEditAlert {
    func favRowEditAction(on viewController: UIViewController, activity: Activity, tableView: UITableView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        SelectedActivity.shared.activity = activity
        if let selectedActivity = SelectedActivity.shared.activity {
            if selectedActivity.fav {
                selectedActivity.fav = false
                print("\(selectedActivity) is now not marked favourite")
            } else {
                selectedActivity.fav = true
                print("\(selectedActivity) is now marked favourite")
            }

            do {
                try context.save()
                SelectedActivity.shared.activity = nil
            } catch {
                print("Can't save the context")
            }
        }
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
}
