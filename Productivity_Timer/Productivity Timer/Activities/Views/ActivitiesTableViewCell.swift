
import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    lazy var activityTitleLabel: UILabel = {
        let activityTitleLabel = UILabel()
        activityTitleLabel.textColor = pinkyWhiteColor
        activityTitleLabel.font = .boldSystemFont(ofSize: 16)
        activityTitleLabel.textAlignment = .left
        return activityTitleLabel
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
        contentView.backgroundColor = blueMoonlight
        setConstraints()
    }

    func set(object: Activity) {
        self.activityTitleLabel.text = object.title
    }

    private func setConstraints() {
        activityTitleLabel.anchor(top: contentView.topAnchor,
                                  left: contentView.leftAnchor,
                                  paddingLeft: 16,
                                  width: self.frame.width,
                                  height: 40)
    }
}
