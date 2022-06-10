
import UIKit
import CoreData

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        focusTextLabelDidTapped = true
        focusActivityCheck()

        if focusCurrentText == "" {
            conformAlert.isEmptyTextFields(on: self, with: "Nah", message: "The text field can't be empty")
            return true

        } else {
            var duplicateIndex: Int?
            duplicateIndex = ActivitiesObject.arrayOfActivities.firstIndex(where: { $0.title == focusCurrentText})

            print("Found duplicate index: \(String(describing: duplicateIndex))")

            if duplicateIndex != nil {
                duplicateIndex = nil
                conformAlert.isEmptyTextFields(on: self, with: "Sorry", message: "Activity already exists")
                print("Index \(String(describing: duplicateIndex)) cleared")
                return false
                
            } else {

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
                ActivitiesObject.arrayOfActivities.append(newActivity)

                do {
                    try context.save()
                    print("New activity \(newActivity.title ?? "") is created and being focused")
                } catch {
                    print("Can't save the context")
                }

                focusCurrentText = nil
                return false
            }
        }
    }
}
