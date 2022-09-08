//
//  CoreDataSaver.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 08.09.2022.
//

import UIKit
import CoreData

class CoreDataSaver {
    func saveFocusActivityToCoreData(controller: TimerViewController, timerView: TimerView) {
        controller.focusTextLabelDidTapped = true
        controller.focusActivityCheck()

        if controller.focusCurrentText == "" {
            controller.focusCurrentText = nil
            controller.focusTextLabelDidTapped = false
            return

        } else {
            var duplicateIndex: Int?
            duplicateIndex = ActivitiesObject.arrayOfActivities.firstIndex(where: { $0.title == controller.focusCurrentText})
            print("Found duplicate index: \(String(describing: duplicateIndex))")

            if duplicateIndex != nil {
                duplicateIndex = nil

                let alert = UIAlertController(title: "Sorry", message: "Activity already exists", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                controller.present(alert, animated: true)

                print("Index \(String(describing: duplicateIndex)) cleared")
                controller.focusTextLabelDidTapped = false

                timerView.focusTextField.isHidden = false
                timerView.focusLabel.text = "tap to focus on activity"
                timerView.focusLabel.textColor = .systemGray
                timerView.focusLabel.layer.opacity = 0.3
                return

            } else {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)

                if let entity = entity {
                    let newActivity = Activity(entity: entity, insertInto: context)
                    newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
                    newActivity.title = controller.focusCurrentText
                    newActivity.fav = false
                    newActivity.isDone = false

                    for activities in ActivitiesObject.arrayOfActivities {
                        activities.isFocused = false
                        print("Activity (\(activities.title ?? "")) is NOT focused EXCEPT \(newActivity.title ?? "")")
                    }

                    newActivity.isFocused = true

                    print("Now Focused Activity is \(newActivity.title ?? "")")
                    ActivitiesObject.arrayOfActivities.append(newActivity)

                    SelectedActivity.shared.activity = newActivity
                    SelectedActivity.shared.selectedIndexToDelete = newActivity.id as? Int

                    do {
                        try context.save()
                        print("New activity \(newActivity.title ?? "") is created and being focused")
                    } catch {
                        print("Can't save the context")
                    }
                    controller.focusCurrentText = nil
                    return
                }
            }
        }
    }
}
