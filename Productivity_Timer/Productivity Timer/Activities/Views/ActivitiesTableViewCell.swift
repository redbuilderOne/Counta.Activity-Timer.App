
import UIKit

class ActivitiesTableViewCell: UITableViewCell {

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()

    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
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
    }

    func set(object: Activity) {
        self.nameLabel.text = object.title
        self.descriptionLabel.text = object.description
    }
}
