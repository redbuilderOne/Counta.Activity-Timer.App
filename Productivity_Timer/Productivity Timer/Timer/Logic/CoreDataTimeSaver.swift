//
//  CoreDataTimeLabelSaver.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 08.09.2022.
//

import UIKit
import CoreData

class CoreDataTimeSaver {
    var currentTimeValue: (Int, Int, Int)?
    var timeSpentStringSum: (String, String, String)?

    func loadPersistentContainer() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        return context
    }

    func loadLastSessionTime() -> String {
        //        let context = loadPersistentContainer()
        let lastSession: String

        for activity in ActivitiesObject.arrayOfActivities {
            if activity.isFocused {
                lastSession = activity.lastSession ?? "00:00:00"
                return lastSession
            }
        }
        return "00:00:00"
    }

    func saveTime(timerFormat: TimerFormat, val: Int, timerView: TimerView) {
        let context = loadPersistentContainer()

        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString

        for activity in ActivitiesObject.arrayOfActivities {
            if activity.isFocused {
                activity.lastSession = timeString
                let lastSessionStringArray = activity.lastSession.map(){$0}
                print("lastSessionStringArray: \(lastSessionStringArray)")
            }
        }

        do {
            try context.save()
            sumSavedTime()
        } catch {
            print("Can't save the context")
        }
    }

    private func sortTimeValues(_ timeString: String?) -> [Int] {
        var resultArray: [Int] = []
        let lastSessionStringArray = timeString.map(){$0}
        guard let sorted = lastSessionStringArray?.components(separatedBy: ":") else { return [] }
        resultArray = sorted.map { Int($0)! }
        return resultArray
    }

    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func converter(_ seconds: Int) {
        let seconds = seconds

        print(String((seconds / 86400)) + " days")
        print(String((seconds % 86400) / 3600) + " hours")
        print(String((seconds % 3600) / 60) + " minutes")
        print(String((seconds % 3600) % 60) + " seconds")
    }


    func convertTotal (_ val: Int) {
        let timerFormat = TimerFormat()
        let totalArray = timerFormat.converter(val)
        let context = loadPersistentContainer()

        totalArray

        do {
            try context.save()
        } catch {
            print("Convert Total Error")
        }
    }

    // TODO
//    func sumSavedTime(currentTimeValue: String, newTimeValue: String)
    func sumSavedTime() {
        let context = loadPersistentContainer()
        let lastSessionTimeString = loadLastSessionTime()
        let timerFormat = TimerFormat()
        var sortedLastSession: [Int] = []
        var sortedSavedSession: [Int] = []


        for activity in ActivitiesObject.arrayOfActivities {
            if activity.isFocused {
                activity.timeSpentInTotal = "00:12:33"
                sortedLastSession = sortTimeValues(activity.lastSession)
                sortedSavedSession = sortTimeValues(activity.timeSpentInTotal)

//                converter(sortedLastSession[2])

                let seconds = sortedLastSession[2] + sortedSavedSession[2]
                let minutes = sortedLastSession[1] + sortedSavedSession[1]
                let hours = sortedLastSession[0] + sortedSavedSession[0]



            }

                print(sortedLastSession)
                print(sortedSavedSession)

//                let newArray = (sortedLastSession[0] + sortedSavedSession[0], sortedLastSession[1] + sortedSavedSession[1], sortedLastSession[2] + sortedSavedSession[2])
//                print("newArray: \(newArray)")

//                activity.timeSpentInTotal = timerFormat.convertTimeToString(hour: newArray.0, min: newArray.1, sec: newArray.2)

//                let hours =
//                let minutes =


                print("activity.timeSpentInTotal: \(activity.timeSpentInTotal)")
            }


                do {
                    try context.save()
                } catch {
                    print("Can't save the context")
                }


                

            }

}
