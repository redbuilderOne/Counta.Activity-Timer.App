//
//import UIKit
//
//class ShapeLayer {
//
//    let shapeLayer = CAShapeLayer()
//    weak var timerView: TimerView?
//
//    func animateCircular() {
//        if let timerView = timerView {
//            let center = CGPoint(x: timerView.elipseView.frame.width / 2, y: timerView.elipseView.frame.height / 2)
//            let endAngle = (-CGFloat.pi / 2)
//            let startAngle = 2 * CGFloat.pi + endAngle
//            let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//            shapeLayer.opacity = 1
//            shapeLayer.path = circularPath.cgPath
//            shapeLayer.lineWidth = 1
//            shapeLayer.fillColor = UIColor.clear.cgColor
//            shapeLayer.strokeEnd = 1
//            shapeLayer.lineCap = CAShapeLayerLineCap.round
//            shapeLayer.strokeColor = sandyYellowColor.cgColor
//            timerView.elipseView.layer.addSublayer(shapeLayer)
//        }
//    }
//}
