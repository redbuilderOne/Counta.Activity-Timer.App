
import UIKit

class NewActivityView: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = darkMoonColor
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        configureUIElements()
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        view.backgroundColor = darkMoonColor
    }

    //MARK: - Constraints
    private func configureUIElements() {
        descriptionTextView.anchor(height: 356)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            descriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            descriptionTextView.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
}
