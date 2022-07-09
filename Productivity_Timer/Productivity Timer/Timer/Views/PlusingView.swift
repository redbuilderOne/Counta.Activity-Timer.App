
import UIKit

class PulsingView: UIView {
    init() {
        super.init(frame: .zero)
        layer.addSublayer(pulsingLayer)
        layer.addSublayer(mainLayer)
        pulsingLayer.add(expandingAnimation, forKey: nil)
        pulsingLayer.add(fadedAnimation, forKey: nil)
//        pulsingLayer.removeAllAnimations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private lazy var expandingAnimation: CABasicAnimation = {
        let expandingAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandingAnimation.fromValue = 1
        expandingAnimation.toValue = 1.4
        expandingAnimation.duration = 1.5
        expandingAnimation.repeatCount = .infinity
        return expandingAnimation
    }()

    private lazy var fadedAnimation: CABasicAnimation = {
        let fadedAnimation = CABasicAnimation(keyPath: "opacity")
        fadedAnimation.fromValue = 1
        fadedAnimation.toValue = 0
        fadedAnimation.duration = 1.5
        fadedAnimation.repeatCount = .infinity
        return fadedAnimation
    }()

    private let mainLayer: CAShapeLayer = circleLayer(Constant.mainColor)
    private let pulsingLayer: CAShapeLayer = circleLayer(Constant.pulsingColor)

    private static func circleLayer(_ color: CGColor) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.path = Constant.bezierPath.cgPath
        circleLayer.lineWidth = 30
        circleLayer.strokeColor = color
        circleLayer.fillColor = UIColor.clear.cgColor
        return circleLayer
    }

    private enum Constant {
        static let bezierPath: UIBezierPath = .init(arcCenter: CGPoint.zero, radius: 150, startAngle: -(CGFloat.pi / 2), endAngle: -(CGFloat.pi / 2) + (CGFloat.pi * 2), clockwise: true)

        static let mainColor = pinkyWhiteColor.cgColor

        static let pulsingColor = blueMoonlight.cgColor
    }
}