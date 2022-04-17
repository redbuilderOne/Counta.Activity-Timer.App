
import UIKit

func createNewActivity(img: String, name: String, description: String) -> Activity {

    let newActivity = Activity(img: img, name: name, description: description, isFavourite: false)
    return newActivity
    
}
