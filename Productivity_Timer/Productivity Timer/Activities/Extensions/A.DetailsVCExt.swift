
import UIKit
import CoreData

extension ActivityDetailedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Your Activity"
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.textLabel?.textColor = sandyYellowColor
            cell.backgroundColor = darkMoonColor
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textAlignment = .justified
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .gray
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.title
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = pinkyWhiteColor
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
            cell.textLabel?.textAlignment = .justified
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.textLabel?.text = "Description"
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = sandyYellowColor
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textAlignment = .justified
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.desc
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = pinkyWhiteColor
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
            cell.textLabel?.textAlignment = .justified
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.text = "Favorite"
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.textLabel?.textColor = sandyYellowColor
            cell.textLabel?.textAlignment = .justified
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = pinkyWhiteColor
            cell.textLabel?.textAlignment = .justified
            if activity.fav {
                cell.imageView?.image = UIImage(systemName: "heart.fill")
                cell.textLabel?.text = "favorite"
                cell.imageView?.tintColor = .systemRed
            } else {
                cell.imageView?.image = UIImage(systemName: "heart")
                cell.textLabel?.text = "not favorite"
                cell.imageView?.tintColor = .systemGray
            }
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
            return cell
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 50
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}
