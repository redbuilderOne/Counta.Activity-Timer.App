
import Foundation

struct Activity {
    var img: String?
    var title: String
    var description: String?
    var isFavourite: Bool?
    var timeSpent: String?

    func createNewActivity(img: String, name: String, description: String) -> Activity {

        let newActivity = Activity(img: img, title: name, description: description, isFavourite: false)
        return newActivity
    }

}
