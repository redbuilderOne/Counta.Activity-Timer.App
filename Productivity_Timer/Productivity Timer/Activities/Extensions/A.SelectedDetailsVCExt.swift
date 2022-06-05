
import UIKit
import CoreData

extension ActivityDetailedViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedIndexPath = tableView.indexPathForSelectedRow
        guard selectedIndexPath?.section != 0 || selectedIndexPath?.section != 1 || selectedIndexPath?.section != 3 || selectedIndexPath?.section != 4 else { return }

        // MARK: FAVOURITE EDITING
        if selectedIndexPath?.row == 0 {
            favRowEditAlert.favRowEditAction(on: self, activity: activity, tableView: tableView)
        }

        // MARK: TITLE EDITING
        if selectedIndexPath?.row == 1 {
            titleRowEditAlert.titleRowEditAction(on: self, activity: activity, tableView: tableView)
        }

        // MARK: DESCRIPTION EDITING
        if selectedIndexPath?.row == 3 {
            descRowEditAlert.descRowEditAction(on: self, activity: activity, tableView: tableView)
        }

        // MARK: FOCUS EDITING
        if selectedIndexPath?.row == 4 {
            focusRowEditAlert.focusRowEditAction(on: self, activity: activity, tableView: tableView)

            conformDeleteAlert.focusOnActivityConfirm(on: self, with: "\(activity.title ?? "your activity") is now being focused", message: "You can return to Timer")
        }
    }
}
