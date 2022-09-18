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

//    func stackTimeToContext(context: NSManagedObjectContext) {
//        var lastSessionIntArray: [Int]
//        var spentIntTotalSeconds: [Int]
//        var spentIntTotalMinutes: [Int]
//        var spentIntTotalHours: [Int]
//
//        if let selectedActivity = SelectedActivity.shared.activity {
//            lastSessionIntArray = sortTimeValues(selectedActivity.lastSession) // [0, 0, 12]
//            spentIntTotalSeconds = sortTimeValues(selectedActivity.spentInTotalSeconds)
//            spentIntTotalMinutes = sortTimeValues(selectedActivity.spentInTotalMinutes)
//            spentIntTotalHours = sortTimeValues(selectedActivity.spentInTotalHours)
//
//            if spentIntTotalSeconds.isEmpty && spentIntTotalMinutes.isEmpty && spentIntTotalHours.isEmpty == false {
//                selectedActivity.spentInTotalSeconds! += String((lastSessionIntArray[2] + spentIntTotalSeconds.first!))
//                selectedActivity.spentInTotalMinutes = String((lastSessionIntArray[1] + spentIntTotalMinutes.first!))
//                selectedActivity.spentInTotalHours = String((lastSessionIntArray[0] + spentIntTotalHours.first!))
//            }
//
//            print("selectedActivity.sec: \(selectedActivity.spentInTotalSeconds)")
//        }
//
//        do {
//            try context.save()
//        } catch {
//            print("Can't save the context")
//        }
//    }
}

    /*
    func sumTotals(hours: Int, minutes: Int, seconds: Int) {
        let context = loadPersistentContainer()
        for i in ActivitiesObject.arrayOfActivities {
            if i.isFocused {
                guard var currentSeconds = Int(i.spentInTotalSeconds!),
                      var currentMinutes = Int(i.spentInTotalMinutes!),
                      var currentHours = Int(i.spentInTotalHours!) else { return }

                currentSeconds += seconds
                i.spentInTotalSeconds! = String(currentSeconds)
                print("i.spentInTotalSeconds!: \(i.spentInTotalSeconds!)")

                currentMinutes += minutes
                i.spentInTotalMinutes! = String(currentMinutes)
                print("i.spentInTotalMinutes!: \(i.spentInTotalMinutes!)")

                currentHours += hours
                i.spentInTotalHours! = String(currentHours)
                print("i.spentInTotalHours!: \(i.spentInTotalHours!)")
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


    func setTotalIntToString(days: Int, hours: Int, minutes: Int, seconds: Int) {
        let context = loadPersistentContainer()
        var activity: Activity?

        for i in ActivitiesObject.arrayOfActivities {
            if i.isFocused {
                activity = i
            }
        }

        activity?.spentInTotalSeconds = String(seconds)
        activity?.spentInTotalMinutes = String(minutes)
        activity?.spentInTotalHours = String(hours)
        activity?.spentInTotalDays = String(days)

        do {
            try context.save()
        } catch {
            print("error")
        }
        activity = nil
    }
}
*/
