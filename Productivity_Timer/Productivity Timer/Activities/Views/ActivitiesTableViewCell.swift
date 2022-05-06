
import UIKit

class ActivitiesTableViewCell: UITableViewCell {

    lazy var activityTitleLabel: UILabel = {
        let activityTitleLabel = UILabel()
        activityTitleLabel.text = "Hello"
        activityTitleLabel.textColor = pinkyWhiteColor
        activityTitleLabel.font = .boldSystemFont(ofSize: 16)
        activityTitleLabel.textAlignment = .left
        activityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return activityTitleLabel
    }()

    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "World"
        descriptionLabel.textColor = pinkyWhiteColor
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(activityTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = blueMoonlight
        setConstraints()
    }

    func set(object: Activity) {
        self.activityTitleLabel.text = object.title
        self.descriptionLabel.text = object.desc
    }

    //MARK: Constraints
    private func setConstraints() {
        activityTitleLabel.anchor(top: contentView.topAnchor,
                                  left: contentView.leftAnchor,
                                  paddingLeft: 16,
                                  width: self.frame.width,
                                  height: self.frame.height)

        descriptionLabel.anchor(top: activityTitleLabel.bottomAnchor,
                                left: contentView.leftAnchor,
                                right: contentView.rightAnchor,
                                paddingLeft: 16,
                                width: self.frame.width,
                                height: self.frame.height)
    }
}
