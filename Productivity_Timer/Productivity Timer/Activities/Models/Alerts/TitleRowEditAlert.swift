
import UIKit
import CoreData

struct TitleRowEditAlert {
    func titleRowEditAction(on vc: UIViewController, activity: Activity, tableView: UITableView) {

        let titleRowEditAction = UIAlertController(title: "Edit Title", message: "Please edit the title", preferredStyle: .alert)
        titleRowEditAction.addTextField(configurationHandler: { (newTitle) -> Void in
            newTitle.text = activity.title
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            vc.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in

            SelectedActivity.selectedActivity = activity

            activity.title = (titleRowEditAction.textFields?.first?.text)!

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
            vc.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        titleRowEditAction.addAction(okayAction)
        titleRowEditAction.addAction(cancelAction)
        vc.present(titleRowEditAction, animated: true, completion: nil)
    }
}

