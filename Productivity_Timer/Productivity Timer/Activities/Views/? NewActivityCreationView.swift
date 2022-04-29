
import UIKit

class NewActivityCreationView: UIView {

    private var newActivityNameText = String()
    private var newActivityDescriptionText = String()
    lazy var addButton = AddButton(tintColor: sandyYellowColor, backgroundColor: pinkyWhiteColor, systemImageName: "plus.circle")

    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()

    lazy var viewForAddingNewActivity: UIView = {
        let viewForAddingNewActivity = UIView()
        viewForAddingNewActivity.backgroundColor = sandyYellowColor
        viewForAddingNewActivity.frame = CGRect(x: 0, y: 100, width: self.frame.width, height: 70)
        viewForAddingNewActivity.translatesAutoresizingMaskIntoConstraints = false
        return viewForAddingNewActivity
    }()

    lazy var textFieldForNewActivity = ActivityTextField(textColor: pinkyWhiteColor, placeholder: "enter new activity title")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        placeTextFields()
        self.addSubview(viewForAddingNewActivity)
        viewForAddingNewActivity.addSubview(textFieldForNewActivity)
        textFieldForNewActivity.delegate = self
    }

    private func placeTextFields() {
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
