
import UIKit

extension ActivityDetailedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Activity"
            cell.textLabel?.font = .boldSystemFont(ofSize: 21)
            cell.textLabel?.textColor = sandyYellowColor
            cell.backgroundColor = darkMoonColor
            cell.isUserInteractionEnabled = true
            cell.textLabel?.textAlignment = .justified

            if activity.fav {
                cell.imageView?.image = UIImage(systemName: "heart.fill")
                cell.imageView?.tintColor = .systemRed
            } else {
                cell.imageView?.image = UIImage(systemName: "heart")
                cell.imageView?.tintColor = .systemGray
            }
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
            cell.imageView?.image = UIImage(systemName: "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.textLabel?.text = "Description"
            cell.textLabel?.font = .boldSystemFont(ofSize: 21)
            cell.imageView?.image = UIImage(systemName: "square.text.square")
            cell.imageView?.tintColor = .systemGray
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = sandyYellowColor
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textAlignment = .justified
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = pinkyWhiteColor
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
            cell.textLabel?.textAlignment = .left
            cell.imageView?.image = UIImage(systemName: "")

            if activity.desc == "" {
                    cell.textLabel?.text = "tap to add your description"
                    cell.textLabel?.font = .boldSystemFont(ofSize: 10)
                    cell.textLabel?.textColor = .systemGray
                    cell.textLabel?.layer.opacity = 0.6
            } else {
                cell.textLabel?.text = activity.desc
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = sandyYellowColor
            cell.textLabel?.textAlignment = .justified
            cell.imageView?.image = UIImage(systemName: "timelapse")
            cell.textLabel?.font = .boldSystemFont(ofSize: 21)

            if activity.isFocused {
                cell.imageView?.image = UIImage(systemName: "timelapse")
                cell.imageView?.tintColor = .systemRed
                cell.textLabel?.text = "Focused"
            } else {
                cell.textLabel?.text = "Tap to focus"
                cell.imageView?.image = UIImage(systemName: "timelapse")
                cell.imageView?.tintColor = .systemGray
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.textLabel?.text = "Time info"
            cell.textLabel?.font = .boldSystemFont(ofSize: 21)
            cell.imageView?.image = UIImage(systemName: "timer")
            cell.imageView?.tintColor = .systemGray
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = sandyYellowColor
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textAlignment = .justified
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .gray
            cell.backgroundColor = darkMoonColor
            cell.textLabel?.textColor = pinkyWhiteColor
            cell.textLabel?.textAlignment = .justified
            cell.imageView?.tintColor = .systemGray
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
            cell.imageView?.image = UIImage(systemName: "")
            cell.textLabel?.text = "Last session: 00:00:00"
            if let lastSession = activity.lastSession {
                cell.textLabel?.text = "Last session: " + lastSession
            }
            return cell
        default:
            fatalError()
        }
    }
}
