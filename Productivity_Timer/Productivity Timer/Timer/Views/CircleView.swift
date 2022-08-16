
import UIKit

class CircleView: UIView {

    init() {
        super.init(frame: .zero)
        layer.addSublayer(trackShapeLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    var roundShapeLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = Constant.bezierPath.cgPath
        shape.lineWidth = 3
        shape.strokeEnd = 0
        shape.strokeColor = pinkyWhiteColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.add(Constant.roundAnimation, forKey: "animation")
        return shape
    }()

    let trackShapeLayer: CAShapeLayer = {
        let trackShape = CAShapeLayer()
        trackShape.path = Constant.bezierPath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 3
        trackShape.strokeColor = blueMoonlight.cgColor
        return trackShape
    }()

    private enum Constant {
        static let roundAnimation: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = 1
            animation.repeatCount = .infinity
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            return animation
        }()

        static let bezierPath: UIBezierPath = .init(arcCenter: CGPoint(x: 150, y: 150),
                                                     radius: 150,
                                                     startAngle: -(.pi / 2),
                                                     endAngle: .pi * 2,
                                                     clockwise: true)

        static let mainColor = pinkyWhiteColor.cgColor

        static let pulsingColor = blueMoonlight.cgColor
    }
}
