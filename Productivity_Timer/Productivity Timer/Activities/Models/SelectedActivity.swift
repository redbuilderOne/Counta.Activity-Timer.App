
import Foundation

struct SelectedActivity {
    static var shared = SelectedActivity()

    var activity: Activity?
    var selectedIndexToDelete: Int?
}
