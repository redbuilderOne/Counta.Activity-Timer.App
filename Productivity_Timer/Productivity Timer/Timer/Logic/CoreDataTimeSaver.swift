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
    var timeSpentIntSum: (Int, Int, Int)?

    func saveTime(timerFormat: TimerFormat, val: Int, timerView: TimerView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        print(time)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString

        for activity in ActivitiesObject.arrayOfActivities {
            if activity.isFocused {
//                timeSpentStringSum = activity.lastSession

                activity.lastSession = timeString
                currentTimeValue = timerFormat.setSecondsToHoursMinutesToHours(val)

                if let currentTimeValue = currentTimeValue {
                    timeSpentIntSum = (timeSpentIntSum?.0 ?? 0 + currentTimeValue.0, timeSpentIntSum?.1 ?? 0 + currentTimeValue.1, timeSpentIntSum?.2 ?? 0 + currentTimeValue.2)

                    print("timeString \(timeString)")
                    print("currentTimeValue \(currentTimeValue)")
                    print("timeSpentIntSum \(timeSpentIntSum)")


                    activity.timeSpentInTotal = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)

//                    activity.timeSpentInTotal = timerFormat.setSecondsToHoursMinutesToHours(timeSpentIntSum)
                }
            }

            do {
                try context.save()
            } catch {
                print("Can't save the context")
            }
        }
    }

    // TODO
    func sumSavedTime(currentTimeValue: String, newTimeValue: String) {

    }
}
