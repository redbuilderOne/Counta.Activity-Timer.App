
import UIKit
import CoreData

extension ActivityTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActivitiesObject.arrayOfActivities.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(ActivityDetailedViewController(activity:  ActivitiesObject.arrayOfActivities[indexPath.row], selectedIndexToDelete: indexPath.row), sender: self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ActivitiesTableViewCell else { fatalError() }
        let object = ActivitiesObject.arrayOfActivities[indexPath.row]
        cell.set(object: object)
        cell.backgroundColor = blueMoonlight
        return cell
    }
}
