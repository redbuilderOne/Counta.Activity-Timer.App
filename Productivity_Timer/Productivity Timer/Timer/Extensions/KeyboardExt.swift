
import UIKit
import CoreData

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        focusTextLabelDidTapped = true
        focusActivityCheck()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
        let newActivity = Activity(entity: entity!, insertInto: context)
        newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
        newActivity.title = focusCurrentText
        newActivity.fav = false
        newActivity.isDone = false
        newActivity.focusedActivityTitle = focusCurrentText
        newActivity.isFocused = true
        FocusedActivity.focusedActivityText = newActivity.title

        do {
            try context.save()
            ActivitiesObject.arrayOfActivities.append(newActivity)
            print("New activity \(newActivity.title ?? "") is created and being focused")
        } catch {
            print("Can't save the context")
        }

        return false
    }
}
