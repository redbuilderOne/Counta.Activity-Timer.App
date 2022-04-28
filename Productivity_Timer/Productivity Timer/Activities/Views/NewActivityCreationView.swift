
import UIKit

class NewActivityCreationView: UIView {

    private var newActivityNameText = String()
    private var newActivityDescriptionText = String()
    lazy var addButton = AddButton(tintColor: sandyYellowColor, backgroundColor: pinkyWhiteColor, systemImageName: "plus.circle")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        placeTextFields()
    }

    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()

    private func placeTextFields() {
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
