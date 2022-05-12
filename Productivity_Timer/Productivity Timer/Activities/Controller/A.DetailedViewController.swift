
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

    private lazy var activityTableView: UITableView = {
        let activityTableView = UITableView()
        activityTableView.translatesAutoresizingMaskIntoConstraints = false
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        activityTableView.backgroundColor = darkMoonColor
        return activityTableView
    }()

    private func confTableView() {
        NSLayoutConstraint.activate([
            activityTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityTableView.topAnchor.constraint(equalTo: view.topAnchor),
            activityTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(activityTableView)
        confTableView()
    }
}
