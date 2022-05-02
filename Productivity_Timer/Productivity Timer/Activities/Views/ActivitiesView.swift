
import UIKit

protocol ActivitiesViewDelegate: AnyObject {
    func plusButtonDidPressed()
}

class ActivitiesView: UIView {
    
    weak var delegate: ActivitiesViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(plusButton)
        placePlusButton()
    }

    // MARK: - plusButton
    lazy var plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = sandyYellowColor
        plusButton.addTarget(self, action: #selector(plusButtonDidPressed), for: .touchUpInside)
        return plusButton
    }()

    // MARK: - protocol delegate
    @objc func plusButtonDidPressed() {
        delegate?.plusButtonDidPressed()
    }

    // MARK: - Constraints
    final private func placePlusButton() {
        plusButton.anchor(width: 50, height: 50)
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    // MARK: - protocol Actions

}
