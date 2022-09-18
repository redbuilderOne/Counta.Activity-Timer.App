
import CoreData

@objc(Activity)

class Activity: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
    @NSManaged var fav: Bool
    @NSManaged var isDone: Bool
    @NSManaged var isFocused: Bool
    @NSManaged var lastSession: String?
    @NSManaged var spentInTotalDays: NSNumber?
    @NSManaged var spentInTotalHours: NSNumber?
    @NSManaged var spentInTotalMinutes: NSNumber?
    @NSManaged var spentInTotalSeconds: NSNumber?
    @NSManaged var timeSpentInTotal: String?
}
