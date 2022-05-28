
import UIKit
import CoreData

extension ActivityDetailedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let selectedIndexPath = tableView.indexPathForSelectedRow
//        guard selectedIndexPath?.section != 1 || selectedIndexPath?.section != 3 else { return }
//
//        if selectedIndexPath?.row == 1 {
//            let titleRowEditAction = UIAlertController(title: "Edit Title", message: "Please edit the title", preferredStyle: .alert)
//            titleRowEditAction.addTextField(configurationHandler: { (newTitle) -> Void in
//                newTitle.text = self.activity.title
//            })
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
//                self.presentingViewController?.dismiss(animated: true, completion: nil)
//            })
//
//            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//
//                SelectedActivity.selectedActivity = self.activity
//
//                self.activity.title = (titleRowEditAction.textFields?.first?.text)!
//
//                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
//                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//                if SelectedActivity.selectedActivity != nil {
//
//                    do {
//                        try context.save()
//                        SelectedActivity.selectedActivity = nil
//                    } catch {
//                        print("Can't save the context")
//                    }
//                }
//
//                tableView.reloadData()
//                self.presentingViewController?.dismiss(animated: true, completion: nil)
//            })
//            titleRowEditAction.addAction(okayAction)
//            titleRowEditAction.addAction(cancelAction)
//            self.present(titleRowEditAction, animated: true, completion: nil)
//        }
//
//        if selectedIndexPath?.row == 3 {
//            let descRowEditAction = UIAlertController(title: "Edit Description", message: "Please edit the description", preferredStyle: .alert)
//            descRowEditAction.addTextField(configurationHandler: { (newDescription) -> Void in
//                newDescription.text = self.activity.desc
//            })
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
//                self.presentingViewController?.dismiss(animated: true, completion: nil)
//            })
//
//            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//
//                SelectedActivity.selectedActivity = self.activity
//                self.activity.desc = (descRowEditAction.textFields?.first?.text)!
//
//                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
//                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//                if SelectedActivity.selectedActivity != nil {
//                    do {
//                        try context.save()
//                        SelectedActivity.selectedActivity = nil
//                    } catch {
//                        print("Can't save the context")
//                    }
//                }
//
//                tableView.reloadData()
//                self.presentingViewController?.dismiss(animated: true, completion: nil)
//            })
//            descRowEditAction.addAction(okayAction)
//            descRowEditAction.addAction(cancelAction)
//            self.present(descRowEditAction, animated: true, completion: nil)
//        }
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Your Activity"
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.textLabel?.textColor = sandyYellowColor
            cell.backgroundColor = darkMoonColor
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .gray
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.title
            cell.backgroundColor = darkMoonColor
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.textLabel?.text = "Description"
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.textLabel?.textColor = sandyYellowColor
            cell.backgroundColor = darkMoonColor
            cell.isUserInteractionEnabled = false
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.desc
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor

            if activity.fav {
                cell.imageView?.image = UIImage(systemName: "heart.fill")
                cell.imageView?.tintColor = .systemRed
            } else {
                cell.imageView?.image = UIImage(systemName: "heart")
                cell.imageView?.tintColor = .systemGray
            }

            return cell
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 50
        default:
            return UITableView.automaticDimension
        }
    }
}
