
import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }

    func useCreatedTimerVC() -> UINavigationController {
        TimerViewControllerStruct.timerViewController.title = "Timer"
        TimerViewControllerStruct.timerViewController.tabBarItem.image = UIImage(systemName: "stopwatch")
        TimerViewControllerStruct.timerViewController.tabBarItem.selectedImage = UIImage(systemName:  "stopwatch.fill")
        return UINavigationController(rootViewController: TimerViewControllerStruct.timerViewController)
    }

    func createTimerNavigationController() -> UINavigationController {
        let timerViewController = TimerViewController()
        timerViewController.title = "Timer"
        timerViewController.tabBarItem.image = UIImage(systemName: "stopwatch")
        timerViewController.tabBarItem.selectedImage = UIImage(systemName:  "stopwatch.fill")
        return UINavigationController(rootViewController: timerViewController)
    }

    func createActivitiesNavigationController() -> UINavigationController {
        let activityTableViewController = ActivityTableViewController()
        activityTableViewController.actionHandler = { [weak activityTableViewController] in activityTableViewController?.dismiss(animated: true, completion: nil)
        }
        activityTableViewController.title = "Activities"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: pinkyWhiteColor]
        activityTableViewController.tabBarItem.image = UIImage(systemName:   "gearshape.circle")
        activityTableViewController.tabBarItem.selectedImage = UIImage(systemName:  "gearshape.circle.fill")
        return UINavigationController(rootViewController: activityTableViewController)
    }
//    let activityTableViewController = ActivityTableViewController()
//        activityTableViewController.title = "Activities"
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: pinkyWhiteColor]
//        activityTableViewController.tabBarItem.image = UIImage(systemName:   "gearshape.circle")
//        activityTableViewController.tabBarItem.selectedImage = UIImage(systemName:  "gearshape.circle.fill")
//        return UINavigationController(rootViewController: activityTableViewController)
//    }

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = sandyYellowColor
        UITabBar.appearance().unselectedItemTintColor = pinkyWhiteColor
        tabBar.viewControllers = [useCreatedTimerVC(), createActivitiesNavigationController()]
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
