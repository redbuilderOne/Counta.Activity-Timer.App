
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

//MARK: - Custom Colors Set#1
let customTestColor = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
let darkMoonColor = UIColor(rgb: 0x1b212d)
let sandyYellowColor = UIColor(rgb: 0xFB6E1F)
let pinkyWhiteColor = UIColor(rgb: 0xF2E9D8)
let fadingWhiteColor = UIColor(rgb: 0xEBEBED)

//MARK: - Custom Colors Set#2
let greenGrassColor = UIColor(rgb: 0x9BDA14)
let purpleGumColor = UIColor(rgb: 0xD499E2)
let blueMoonlight = UIColor(rgb: 0x2F394E)
let perfectWhite = UIColor(rgb: 0xFFFFFF)
