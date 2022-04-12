
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }

    func createTimerNavigationController() -> UINavigationController {
        let timerViewController = TimerViewController()
        timerViewController.title = "Timer"
        timerViewController.tabBarItem.image = UIImage(systemName: "stopwatch")
        timerViewController.tabBarItem.selectedImage = UIImage(systemName:  "stopwatch.fill")
        return UINavigationController(rootViewController: timerViewController)
    }

    func createActivitiesNavigationController() -> UINavigationController {
        let activitiesViewController = ActivitiesViewController()
        activitiesViewController.title = "Activities"
        activitiesViewController.tabBarItem.image = UIImage(systemName:   "gearshape.circle")
        activitiesViewController.tabBarItem.selectedImage = UIImage(systemName:  "gearshape.circle.fill")
        return UINavigationController(rootViewController: activitiesViewController)
    }

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = pinkyWhiteColor
        UITabBar.appearance().unselectedItemTintColor = darkMoonColor
        UITabBar.appearance().backgroundColor = sandyYellowColor
        tabBar.viewControllers = [createTimerNavigationController(), createActivitiesNavigationController()]

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
