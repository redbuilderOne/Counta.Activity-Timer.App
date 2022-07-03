//
//import UIKit
//
//class TimerViewControllerStruct {
//    let timerViewController: TimerViewController?
//
//    init() {
//        timerViewController = TimerViewController()
//    }
//
////    static var timerViewController = TimerViewController()
//}

struct StaticSelectedActivity {
    static var activity: Activity?

    static func deinitActivity() {
        self.activity = nil
    }
}
