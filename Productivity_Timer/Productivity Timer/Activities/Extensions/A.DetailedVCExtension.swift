
import UIKit
import CoreData

extension ActivityDetailedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedIndexPath = tableView.indexPathForSelectedRow
        guard selectedIndexPath?.section != 1 || selectedIndexPath?.section != 3 else { return }

        if selectedIndexPath?.row == 1 {
            let titleRowEditAction = UIAlertController(title: "Edit Title", message: "Please edit the title", preferredStyle: .alert)
            titleRowEditAction.addTextField(configurationHandler: { (newTitle) -> Void in

                newTitle.text = self.activity.title
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in

                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })

            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in

                SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[indexPath.row]

                self.activity.title = (titleRowEditAction.textFields?.first?.text)!

                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                if SelectedActivity.selectedActivity != nil {
                    guard let newActivity = SelectedActivity.selectedActivity else { return }
                    newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
                    newActivity.title = self.activity.title
                    newActivity.fav = false

                    do {
                        try context.save()
                        ActivitiesObject.arrayOfActivities.append(newActivity)
                        SelectedActivity.selectedActivity = nil
                    } catch {
                        print("Can't save the context")
                    }

                    //                } else  if selectedIndexPath?.row == 3 {
                    //                    let descRowEditAction = UIAlertController(title: "Edit Description", message: "Please edit the description", preferredStyle: .alert)
                    //
                    //                    descRowEditAction.addTextField(configurationHandler: { (newDescription) -> Void in
                    //                        newDescription.text = self.activity.desc
                    //                    })
                    //
                    //                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                    //
                    //                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    //                    })

                    //                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    //
                    //                        SelectedActivity.selectedActivity = ActivitiesObject.arrayOfActivities[indexPath.row]
                    //
                    //                        self.activity.desc = (descRowEditAction.textFields?.first?.text)!
                    //
                    //                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                    //
                    //                        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                    //
                    //                        if SelectedActivity.selectedActivity != nil {
                    //                            guard let newActivity = SelectedActivity.selectedActivity else { return }
                    //                            newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
                    //                            newActivity.title = self.activity.desc
                    //                            newActivity.fav = false
                    //
                    //                            do {
                    //                                try context.save()
                    //
                    //                                ActivitiesObject.arrayOfActivities.append(newActivity)
                    //                                SelectedActivity.selectedActivity = nil
                    //                            } catch {
                    //                                print("Can't save the context")
                    //                            }

                }

                tableView.reloadData()
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
            titleRowEditAction.addAction(okayAction)
            titleRowEditAction.addAction(cancelAction)
            self.present(titleRowEditAction, animated: true, completion: nil)
        }
    }

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
            //        case 3:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //            if activity.isFavourite {
            //            cell.imageView?.image = "heart"
            //            }
            //            cell.textLabel?.numberOfLines = 0
            //            cell.selecti onStyle = .none
            //            return cell
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
