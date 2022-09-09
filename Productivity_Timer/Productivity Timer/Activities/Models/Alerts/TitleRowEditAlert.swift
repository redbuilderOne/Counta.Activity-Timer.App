
import UIKit
import CoreData

struct TitleRowEditAlert {
    let timerViewController: TimerViewController?
    
    func titleRowEditAction(on viewController: UIViewController, activity: Activity, tableView: UITableView) {
        let titleRowEditAction = UIAlertController(title: "Edit Title", message: "Please edit the title", preferredStyle: .alert)
        titleRowEditAction.addTextField(configurationHandler: { (newTitle) -> Void in
            newTitle.text = activity.title
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            SelectedActivity.shared.activity = activity
            activity.title = (titleRowEditAction.textFields?.first?.text)!

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

            timerViewController?.timerView.focusLabel.text = activity.title
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        titleRowEditAction.addAction(okayAction)
        titleRowEditAction.addAction(cancelAction)
        viewController.present(titleRowEditAction, animated: true, completion: nil)
    }
}
