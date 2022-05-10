
import UIKit

class ActivityDetailedViewController: UITabBarController {

    var activity: Activity

    init(activity: Activity) {
        self.activity = activity
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var activityDetailedView: UITableView = {
        let activityDetailedView = UITableView()
        activityDetailedView.translatesAutoresizingMaskIntoConstraints = false
        activityDetailedView.delegate = self
        activityDetailedView.dataSource = self
        activityDetailedView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return activityDetailedView
    }()

    private func confTableView() {
        NSLayoutConstraint.activate([
            activityDetailedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityDetailedView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityDetailedView.topAnchor.constraint(equalTo: view.topAnchor),
            activityDetailedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityDetailedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityDetailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(activityDetailedView)
        confTableView()
    }
}
