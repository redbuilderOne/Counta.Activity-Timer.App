
import UIKit

class AddButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(titleColor: UIColor? = nil, tintColor: UIColor? = nil, backgroundColor: UIColor, systemImageName: String? = nil) {
        super.init(frame: .zero)

        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        if let systemImageName = systemImageName {
            self.setImage(UIImage(systemName: systemImageName), for: .normal)
        }
    }
}
