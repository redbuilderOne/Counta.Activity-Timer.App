
// MARK: DRAFT

/*
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

        // time = (Int, Int, Int)

        for i in ActivitiesObject.arrayOfActivities {
            if i.isFocused {
                i.lastSession = timeString
                sorted = sortTimeValues(timeString)
                // sorted: [Int] = [0, 0, 0]

//                var b = 0
//                b += sorted![2]

//                i.spentInTotalSeconds! = String(sorted![2])


            }


//                var timeSec = 0
//                timeSec += sorted?[2] ?? 0
//                print("timeSec: \(timeSec)")
//                i.spentInTotalSeconds! = String(timeSec)
//
//                SelectedActivity.shared.activity = i
//
//                let hours = sorted?[0] ?? 0
//                let minutes = sorted?[1] ?? 0
//                let seconds = sorted?[2] ?? 0
//
//                let timeTuple: (Int, Int, Int) = (hours + time.0, minutes + time.1, seconds + time.2)
//                print("timeTuple: \(timeTuple)")
//
//                i.timeSpentInTotal = timerFormat.convertTimeToString(hour: timeTuple.0, min: timeTuple.1, sec: timeTuple.2)
//
//                if let selectedActivity = SelectedActivity.shared.activity {
//                    selectedActivity.timeSpentInTotal = timerFormat.convertTimeToString(hour: timeTuple.0, min: timeTuple.1, sec: timeTuple.2)
//                    print("\(selectedActivity.timeSpentInTotal ?? "") timeSpentTOTAL")
//                }
//            }

        }





        do {
            try context.save()
            print("SelectedActivity.shared.activity: \(SelectedActivity.shared.activity?.spentInTotalSeconds)")
        } catch {
            print("Can't save the context")
        }
    }

    func sumTotals(seconds: Int) {
        let context = loadPersistentContainer()

        for i in ActivitiesObject.arrayOfActivities {
            if i.isFocused {
                guard var currentSeconds = Int(i.spentInTotalSeconds!) else { return }
                currentSeconds += seconds
                i.spentInTotalSeconds! = String(currentSeconds)
                print("i.spentInTotalSeconds!: \(i.spentInTotalSeconds!)")
            }
        }

        do {
            try context.save()
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

    func convertTotal(_ val: Int) {
        let timerFormat = TimerFormat()
        let context = loadPersistentContainer()
//        sorted // [Int] = [0, 0, 8]
//        let hours = sorted?[0]
//        let minutes = sorted?[1]
//        let seconds = sorted?[2]










        var coreDataDaysInt, coreDataHoursInt, coreDataMinutesInt, coreDataSecondsInt: Int?


        let totalArray = timerFormat.converter(val)
        print("totalArray: \(totalArray)")
        var secInt = ((String(totalArray[3])) as NSString).integerValue
        var minInt = ((String(totalArray[2])) as NSString).integerValue
        var hourInt = ((String(totalArray[1])) as NSString).integerValue
        var daysInt = ((String(totalArray[0])) as NSString).integerValue

//        for i in ActivitiesObject.arrayOfActivities {
//            if i.isFocused {
//                activityToCheck = i
//            }
//        }

//        activityToCheck = SelectedActivity.shared.activity

//        coreDataSecondsInt = Int((activityToCheck?.spentInTotalSeconds ?? "0"))
//        secInt += coreDataSecondsInt!

//        coreDataSecondsInt = Int((activityToCheck?.spentInTotalSeconds)!)
//        secInt += coreDataSecondsInt!

//        coreDataSecondsInt = (Int(activityToCheck?.spentInTotalSeconds ?? "0") ?? 0) + secInt

//                var secSum: Int = {
//                    var secSum = seconds
//                    secSum! += coreDataSecondsInt ?? 0
//                    return secSum!
//                }()

        setTotalIntToString(days: daysInt, hours: hourInt, minutes: minInt, seconds: secInt)







            do {
                try context.save()
            } catch {
                print("Convert Total Error")
            }
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




        // TODO
        //    func sumSavedTime(currentTimeValue: String, newTimeValue: String)
        func sumSavedTime() {
            let context = loadPersistentContainer()
//            let lastSessionTimeString = loadLastSessionTime()
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

    //    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    //        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    //    }

    //    func loadLastSessionTime() -> String {
    //        let lastSession: String
    //
    //        for activity in ActivitiesObject.arrayOfActivities {
    //            if activity.isFocused {
    //                lastSession = activity.lastSession ?? "00:00:00"
    //                return lastSession
    //            }
    //        }
    //        return "00:00:00"
    //    }
    }




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

    func convertTotal(_ val: Int) {
        let timerFormat = TimerFormat()
        let context = loadPersistentContainer()
//        sorted // [Int] = [0, 0, 8]
//        let hours = sorted?[0]
//        let minutes = sorted?[1]
//        let seconds = sorted?[2]










        var coreDataDaysInt, coreDataHoursInt, coreDataMinutesInt, coreDataSecondsInt: Int?


        let totalArray = timerFormat.converter(val)
        print("totalArray: \(totalArray)")
        var secInt = ((String(totalArray[3])) as NSString).integerValue
        var minInt = ((String(totalArray[2])) as NSString).integerValue
        var hourInt = ((String(totalArray[1])) as NSString).integerValue
        var daysInt = ((String(totalArray[0])) as NSString).integerValue

//        for i in ActivitiesObject.arrayOfActivities {
//            if i.isFocused {
//                activityToCheck = i
//            }
//        }

//        activityToCheck = SelectedActivity.shared.activity

//        coreDataSecondsInt = Int((activityToCheck?.spentInTotalSeconds ?? "0"))
//        secInt += coreDataSecondsInt!

//        coreDataSecondsInt = Int((activityToCheck?.spentInTotalSeconds)!)
//        secInt += coreDataSecondsInt!

//        coreDataSecondsInt = (Int(activityToCheck?.spentInTotalSeconds ?? "0") ?? 0) + secInt

//                var secSum: Int = {
//                    var secSum = seconds
//                    secSum! += coreDataSecondsInt ?? 0
//                    return secSum!
//                }()

        setTotalIntToString(days: daysInt, hours: hourInt, minutes: minInt, seconds: secInt)







            do {
                try context.save()
            } catch {
                print("Convert Total Error")
            }
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




        // TODO
        //    func sumSavedTime(currentTimeValue: String, newTimeValue: String)
        func sumSavedTime() {
            let context = loadPersistentContainer()
//            let lastSessionTimeString = loadLastSessionTime()
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

    //    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    //        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    //    }

    //    func loadLastSessionTime() -> String {
    //        let lastSession: String
    //
    //        for activity in ActivitiesObject.arrayOfActivities {
    //            if activity.isFocused {
    //                lastSession = activity.lastSession ?? "00:00:00"
    //                return lastSession
    //            }
    //        }
    //        return "00:00:00"
    //    }
    }


