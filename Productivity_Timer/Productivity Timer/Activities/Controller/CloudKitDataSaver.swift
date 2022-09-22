//
//  CloudKitSaver.swift
//  Counta
//
//  Created by Дмитрий Скворцов on 22.09.2022.
//

import Foundation
import CloudKit

class CloudKitDataSaver {
    private var database = CKContainer(identifier: "iCloud.ATimer.app").sharedCloudDatabase

    func saveItemToDataBase(name: String) {
        let record = CKRecord(recordType: "ActivityItem")
        record.setValue(name, forKey: "name")
        database.save(record) { record, error in
            if record != nil && error == nil {
                print("saved")
            } else {
                print("not saved")
            }
        }
    }

}
