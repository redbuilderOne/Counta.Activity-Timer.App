
import UIKit

class NewActivityView: UIView {

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
        textField.font = .systemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        descriptionTextView.backgroundColor = .systemGray6
        return descriptionTextView
    }()

    lazy var clearButton = TimerControlButton(title: "clear", titleColor: .black, tintColor: .black, backgroundColor: pinkyWhiteColor, systemImageName: "xmark.square")

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
        configureUIElements()
    }

    //MARK: - Constraints
    final private func configureUIElements() {
        descriptionTextView.anchor(height: 356)
        clearButton.anchor(height: 50)
        
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
            clearButton.trailingAnchor.constraint(equalTo: descriptionTextView.trailingAnchor),
            clearButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
}
