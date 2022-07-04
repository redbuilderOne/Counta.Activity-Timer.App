
import Foundation

struct StaticSelectedActivity {
    static var activity: Activity?

    static func deinitActivity() {
        self.activity = nil
    }
}
