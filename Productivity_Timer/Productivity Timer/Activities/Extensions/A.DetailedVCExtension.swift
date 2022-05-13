
import UIKit

extension ActivityDetailedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let indexPath = tableView.indexPathForSelectedRow!

        let activityDetail = NewActivityViewController()

        let selectedActivity : Activity!
        selectedActivity = ActivityTableViewController.nonDeletedActivities()[indexPath.row]
        activityDetail.selectedActivity = selectedActivity

        tableView.deselectRow(at: indexPath, animated: true)

        show(createNewActivityView, sender: self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .gray
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.title
            cell.backgroundColor = blueMoonlight
            cell.textLabel?.resignFirstResponder()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.desc
            cell.selectionStyle = .none
            cell.backgroundColor = blueMoonlight
            cell.isUserInteractionEnabled = false
            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            if activity.isFavourite {
//            cell.imageView?.image = "heart"
//            }
//            cell.textLabel?.numberOfLines = 0
//            cell.selectionStyle = .none
//            return cell
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 50
        case 1:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }
}


