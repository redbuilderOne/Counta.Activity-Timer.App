//
//  CoreDataTimeLabelSaver.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 08.09.2022.
//

import UIKit
import CoreData

class CoreDataTimeSaver {
    func loadPersistentContainer() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        return context
    }

    func saveTime(timerFormat: TimerFormat, val: Int, timerView: TimerView) {
        let context = loadPersistentContainer()
        guard let activity = loadActivitesFromCoreData(context: context) else { return }

        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString

        for i in ActivitiesObject.arrayOfActivities {
            if i.isFocused {
                i.lastSession = timeString
            }
        }

        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
    }

    func sortTimeValues(_ timeString: String?) -> [Int] {
        var resultArray: [Int] = []
        let lastSessionStringArray = timeString.map(){$0}
        guard let sorted = lastSessionStringArray?.components(separatedBy: ":") else { return [] }
        resultArray = sorted.map { Int($0)! }
        return resultArray
    }

    private func loadActivitesFromCoreData(context: NSManagedObjectContext) -> Activity? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")

        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let activity = result as! Activity
                return activity
            }
        } catch {
            print("Fetch failed")
        }
        return nil
    }

    func saveStackedTime(context: NSManagedObjectContext) {
        guard let activity = loadActivitesFromCoreData(context: context) else { return }
        var sorted: [Int]

        for i in ActivitiesObject.arrayOfActivities {
            if i.isFocused {
                sorted = sortTimeValues(i.lastSession)
                print("sorted: \(sorted)")

                var secs = i.spentInTotalSeconds as! Int

                if sorted.isEmpty == false {
                    secs += sorted[2]
                }

                i.spentInTotalSeconds = secs as NSNumber
                print("activity.spentInTotalSeconds: \(i.spentInTotalSeconds)")
            }
        }
    }
}
