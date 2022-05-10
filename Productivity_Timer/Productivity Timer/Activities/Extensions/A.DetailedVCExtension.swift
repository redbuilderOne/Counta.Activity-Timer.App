
import UIKit

extension ActivityDetailedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.title
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = activity.description
            cell.imageView?.contentMode = .scaleAspectFill
            cell.selectionStyle = .none
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
            return 200
        case 2:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }
}


