
import UIKit
import CoreData

struct DescRowEditAlert {
    func descRowEditAction(on viewController: UIViewController, activity: Activity, tableView: UITableView) {
        let descRowEditAction = UIAlertController(title: "Edit Description", message: "Please edit the description", preferredStyle: .alert)
        descRowEditAction.addTextField(configurationHandler: { (newDescription) -> Void in
            newDescription.text = activity.desc
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            SelectedActivity.shared.activity = activity
            activity.desc = (descRowEditAction.textFields?.first?.text)!

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

            if SelectedActivity.shared.activity != nil {
                do {
                    try context.save()
                    SelectedActivity.shared.activity = nil
                } catch {
                    print("Can't save the context")
                }
            }

            tableView.reloadData()
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        descRowEditAction.addAction(okayAction)
        descRowEditAction.addAction(cancelAction)
        viewController.present(descRowEditAction, animated: true, completion: nil)
    }
}
