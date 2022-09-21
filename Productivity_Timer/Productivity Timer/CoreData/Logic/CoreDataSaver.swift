//
//  CoreDataSaver.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 08.09.2022.
//

import UIKit
import CoreData

class CoreDataSaver {
    func loadPersistentContainer() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        return context
    }

    func createCoreDataNewActivity(controller: TimerViewController? = nil, titleText: String? = nil, descText: String? = nil, entity: NSEntityDescription, insertInto: NSManagedObjectContext, isFocused: Bool) -> Activity {
        let newActivity = Activity(entity: entity, insertInto: loadPersistentContainer())
        newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
        newActivity.title = "New Activity"
        if let controller = controller {
            newActivity.title = controller.focusCurrentText
        } else {
            newActivity.title = titleText
        }
        if let descText = descText {
            newActivity.desc = descText
        } else {
            newActivity.desc = ""
        }
        newActivity.fav = false
        newActivity.isDone = false
        newActivity.timeSpentInTotal = "00:00:00"
        newActivity.spentInTotalDays = 0 as NSNumber
        newActivity.spentInTotalHours = 0 as NSNumber
        newActivity.spentInTotalMinutes = 0 as NSNumber
        newActivity.spentInTotalSeconds = 0 as NSNumber
        newActivity.isFocused = isFocused
        print("New Activity \(newActivity.title ?? "") is created at \(Date())")
        print(newActivity)
        return newActivity
    }

    func saveNewActivityToCoreData(controller: TimerViewController, timerView: TimerView) {
        controller.focusTextLabelDidTapped = true
        controller.focusActivityCheck()

        if controller.focusCurrentText == "" {
            controller.focusCurrentText = nil
            controller.focusTextLabelDidTapped = false
            return
        } else {
            var duplicateIndex: Int?
            duplicateIndex = ActivitiesObject.arrayOfActivities.firstIndex(where: { $0.title == controller.focusCurrentText })
            print("Found duplicate index: \(String(describing: duplicateIndex))")

            if duplicateIndex != nil {
                duplicateIndex = nil
                let alert = UIAlertController(title: "Sorry", message: "Activity already exists", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                controller.present(alert, animated: true)
                print("Index \(String(describing: duplicateIndex)) cleared")
                controller.focusTextLabelDidTapped = false
                timerView.focusTextField.isHidden = false
                timerView.focusLabel.text = "tap to focus on activity".localized()
                timerView.focusLabel.textColor = .systemGray
                timerView.focusLabel.layer.opacity = 0.3
                return
            } else {
                let context = loadPersistentContainer()
                guard let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context) else { return }
                let newActivity = createCoreDataNewActivity(controller: controller, entity: entity, insertInto: context, isFocused: true)

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
