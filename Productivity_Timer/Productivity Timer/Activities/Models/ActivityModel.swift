
import Foundation

struct ActivityModel {
    var title: String
    var description: String?
    var isFavourite: Bool
    var timeSpent: String?

    func createNewActivity(title: String, description: String) -> ActivityModel {
        let newActivity = ActivityModel(title: title, description: description, isFavourite: false)
        return newActivity
    }
}
