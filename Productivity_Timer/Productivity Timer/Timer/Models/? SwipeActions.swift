//
//import UIKit
//
//struct SwipeRightAction {
//
//    func createSwipeRight(target: UIViewController) {
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToRightSwipeGesture))
//
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        target.view.addGestureRecognizer(swipeRight)
//    }
//
//
//@objc func respondToRightSwipeGesture(gesture: UIGestureRecognizer) {
//    }
////        print ("Swiped right")
////
////        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
////
////            switch swipeGesture.direction {
////            case UISwipeGestureRecognizerDirection.right:
////
////
////                //change view controllers
////
////                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
////
////                self.present(resultViewController, animated:true, completion:nil)
////
////
////            default:
////                break
////            }
////        }
//
//}
