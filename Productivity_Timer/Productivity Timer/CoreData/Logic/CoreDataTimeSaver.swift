//
//  CoreDataTimeLabelSaver.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 08.09.2022.
//

import UIKit
import CoreData

class CoreDataTimeSaver {
    var sorted: [Int]?

    func loadPersistentContainer() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        return context
    }

    func saveTime(timerFormat: TimerFormat, val: Int, timerView: TimerView) {
        let context = loadPersistentContainer()
        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString
        if let selectedActivity = SelectedActivity.shared.activity {
            selectedActivity.lastSession = timeString
            selectedActivity.spentInTotalSeconds! += String(time.2)
            selectedActivity.spentInTotalMinutes! += String(time.1)
            selectedActivity.spentInTotalHours! += String(time.0)
            print(selectedActivity)
        }
        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
    }


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
