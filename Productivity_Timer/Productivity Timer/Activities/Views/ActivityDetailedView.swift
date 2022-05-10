//
//import UIKit
//
//protocol ActivityDetailedViewDelegate: AnyObject {
//    func buttonDidPressed()
//}
//
//class ActivityDetailedView: UIView {
//
//    weak var delegate: ActivityDetailedViewDelegate?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        self.addSubview(plusButton)
////        placePlusButton()
//    }
//
//    // MARK: - protocol delegate
//    @objc func someButtonDidPressed() {
//        delegate?.buttonDidPressed()
//    }
//}
//
