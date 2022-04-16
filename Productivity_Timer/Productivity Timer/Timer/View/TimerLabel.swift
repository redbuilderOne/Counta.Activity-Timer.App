
import UIKit

var timerLabel: UILabel = {
    let timerLabel = UILabel()
    timerLabel.text = "00:00:00"
    timerLabel.textAlignment = .center
    timerLabel.textColor = pinkyWhiteColor
    timerLabel.font = .systemFont(ofSize: 45)
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    return timerLabel
}()
