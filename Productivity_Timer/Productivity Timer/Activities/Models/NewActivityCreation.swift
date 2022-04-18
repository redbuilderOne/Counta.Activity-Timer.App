
import UIKit

func createNewActivity(img: String, name: String, description: String) -> Activity {

    let newActivity = Activity(img: img, title: name, description: description, isFavourite: false)
    return newActivity

}
