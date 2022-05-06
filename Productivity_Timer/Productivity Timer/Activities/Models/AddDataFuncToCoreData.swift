
import Foundation
import CoreData

protocol AddDataToCoreData {
    func addDataToCoreData()
}

extension AddDataToCoreData {
    func addDataToCoreData(appDelegate: AppDelegate, id: Int, title: String, description: String, isFavourite: Bool? = nil) {

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
        let newActivity = Activity(entity: entity!, insertInto: context)
        newActivity.id = id as NSNumber
        newActivity.title = title
        newActivity.desc = description
        newActivity.fav = isFavourite ?? false
    }
}
