//
//import UIKit
//import CoreData
//
//struct InstantCreateAlert {
//    func instantCreateNewActivity(on vc: UIViewController) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//        let addActivityAction = UIAlertController(title: "New Activity", message: "Please add the title", preferredStyle: .alert)
//        addActivityAction.addTextField(configurationHandler: { (newTitle) -> Void in
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
//                vc.presentingViewController?.dismiss(animated: true, completion: nil)
//            })
//
//            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//
//                let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
//                let newActivity = Activity(entity: entity!, insertInto: context)
//                newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
//                newActivity.title = newTitle.text
//                newActivity.fav = false
//                newActivity.isDone = false
//                newActivity.focusedActivityTitle = newTitle.text
//                newActivity.isFocused = true
//                FocusedActivity.focusedActivityText = newActivity.title
//                
//                do {
//                    try context.save()
//                    ActivitiesObject.arrayOfActivities.append(newActivity)
//                } catch {
//                    print("Can't save the context")
//                }
//            })
//
//            vc.view.setNeedsDisplay()
//            addActivityAction.addAction(okayAction)
//            addActivityAction.addAction(cancelAction)
//            vc.present(addActivityAction, animated: true, completion: nil)
//        })
//    }
//}
//
