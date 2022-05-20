
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
        guard selectedIndexPath?.section != 1 || selectedIndexPath?.section != 3 else {
            return
        }

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

                print("\(String(describing: SelectedActivity.selectedActivity))")

                tableView.deselectRow(at: indexPath, animated: true)

                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                if SelectedActivity.selectedActivity != nil {
                    guard let newActivity = SelectedActivity.selectedActivity else { return }
                    newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
                    newActivity.title = self.activity.title
//                    newActivity.desc =  self.desc.title
                    newActivity.fav = false

                    do {
                        try context.save()
                        ActivitiesObject.arrayOfActivities.append(newActivity)
                    } catch {
                        print("Can't save the context")
                    }
                }

                //                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                //                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                //                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
                //                do {
                //                    let results: NSArray = try context.fetch(request) as NSArray
                //                    for result in results {
                //
                //                        let activity = result as! Activity
                //                        if activity == selectedActivity {
                //                            activity.title = (titleRowEditAction.textFields?.first?.text)!
                ////                            activity.desc = newActivityView.descriptionTextView.text
                //                            try context.save()
                //                            print("context is saved")
                //                        }
                //                    }
                //                } catch {
                //                    print("Fetch failed")
                //                }

                tableView.reloadData()
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })

            titleRowEditAction.addAction(okayAction)
            titleRowEditAction.addAction(cancelAction)
            self.present(titleRowEditAction, animated: true, completion: nil)
        }
    }

    //        if selectedIndexPath?.row == 2 {
    //            //The third row is selected and needs to be changed in predefined content using a standard selection action sheet.
    //            let trackLevelAction = UIAlertController(title: "Select Predefined Content”, message: "Please, select the content”, preferredStyle: UIAlertControllerStyle.ActionSheet)
    //
    //            for content in arrayOfPredefinedContent {
    //                predefinedContentAction.addAction(UIAlertAction(title: content, style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
    //
    //                    yourObject.thatNeedsTheNewContent = content
    //                    //Do some other stuff that you want to do
    //                    self.trackDetailsTable.reloadData()
    //                }))
    //
    //            }
    //        titleRowEditAction.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
    //
    //
    //            }))
    //
    //            presentViewController(titleRowEditAction, animated: true, completion: nil)
    //        }

    //        let indexPath = tableView.indexPathForSelectedRow!
    //
    //        NewActivityViewController.selectedActivity = ActivityTableViewController.nonDeletedActivities()[indexPath.row]
    ////        NewActivityViewController.selectedActivity = ActivitiesObject.arrayOfActivities[indexPath.row]
    //
    //        show(createNewActivityView, sender: self)
    //        tableView.deselectRow(at: indexPath, animated: true)

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
            cell.textLabel?.text = activity.desc
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
            cell.isUserInteractionEnabled = false
            return cell
            //        case 3:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //            if activity.isFavourite {
            //            cell.imageView?.image = "heart"
            //            }
            //            cell.textLabel?.numberOfLines = 0
            //            cell.selectionStyle = .none
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
