
import UIKit

protocol NewActivityViewActions: AnyObject {
    func clearButtonDidPressed()
    func okButtonDidPressed()
}

class NewActivityView: UIView {

    weak var delegate: NewActivityViewActions?

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Your new activity is..."
        titleLabel.textColor = pinkyWhiteColor
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "here"
        textField.textColor = sandyYellowColor
        textField.backgroundColor = blueMoonlight
        textField.font = .systemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        return textField
    }()

    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Add description"
        descriptionLabel.textColor = pinkyWhiteColor
        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    lazy var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.font = .systemFont(ofSize: 24)
        descriptionTextView.textColor = sandyYellowColor
        descriptionTextView.backgroundColor = blueMoonlight
        return descriptionTextView
    }()

    lazy var clearButton = TimerControlButton(title: "clear", titleColor: .systemRed, tintColor: .systemRed, backgroundColor: blueMoonlight, systemImageName: "xmark.square")

    lazy var okButton = TimerControlButton(title: "ok", titleColor: .systemGreen, tintColor: .systemGreen, backgroundColor: blueMoonlight, systemImageName: "checkmark")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(textField)
        self.addSubview(descriptionTextView)
        self.addSubview(clearButton)
        self.addSubview(okButton)
        configureUIElements()
        configureButtonsActions()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    private func configureButtonsActions() {
        clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    }

    @objc func clearButtonAction() {
        delegate?.clearButtonDidPressed()
    }

    @objc func okButtonAction() {
        delegate?.okButtonDidPressed()
    }

    //MARK: - Constraints
    final private func configureUIElements() {
        descriptionTextView.anchor(height: 128)
        clearButton.anchor(width: 117, height: 50)
        okButton.anchor(width: 117, height: 50)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            textField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            descriptionLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            descriptionTextView.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            clearButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            clearButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            okButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            okButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
