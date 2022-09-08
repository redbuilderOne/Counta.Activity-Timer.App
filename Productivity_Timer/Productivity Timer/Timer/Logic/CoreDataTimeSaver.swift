//
//  CoreDataTimeLabelSaver.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 08.09.2022.
//

import UIKit
import CoreData

class CoreDataTimeSaver {
    func saveTime(timerFormat: TimerFormat, val: Int, timerView: TimerView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString

        for activity in ActivitiesObject.arrayOfActivities {
            if activity.isFocused {
                activity.lastSession = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
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
