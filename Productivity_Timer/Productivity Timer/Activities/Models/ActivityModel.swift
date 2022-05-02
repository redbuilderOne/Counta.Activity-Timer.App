
import Foundation

struct Activity {
    var title: String
    var description: String?
    var isFavourite: Bool
    var timeSpent: String?

    func createNewActivity(name: String, description: String) -> Activity {
        let newActivity = Activity(title: name, description: description, isFavourite: false)
        return newActivity
    }
}
