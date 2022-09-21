
import UIKit
import CoreData

class ActivityDetailedViewController: UITabBarController, DeleteAlertProtocol {
    var selectedIndexToDelete: Int
    var activity: Activity
    lazy var conformDeleteAlert = DeleteAlert(delegate: self)
    lazy var descRowEditAlert = DescRowEditAlert()
    lazy var favRowEditAlert = FavRowEditAlert()
    let timerViewController: TimerViewController?
    lazy var titleRowEditAlert = TitleRowEditAlert(timerViewController: TimerViewController(activity: activity))
    lazy var focusRowEditAlert = FocusRowEditAlert()

    init(activity: Activity, selectedIndexToDelete: Int) {
        self.activity = activity
        self.selectedIndexToDelete = selectedIndexToDelete
        timerViewController = TimerViewController()
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
        title = "Details".localized()
        SelectedActivity.shared.activity = activity
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(activityTableView)
        confTableView()
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popViewController(animated: true)
    }

    private func setupNavigationBar() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action:  #selector(trashButtonDidTapped))
        self.navigationItem.rightBarButtonItem = trashButton
        self.navigationItem.rightBarButtonItem?.tintColor = sandyYellowColor
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
    }

    @objc func trashButtonDidTapped() {
        conformDeleteAlert.deleteActivity(on: self, with: "Are you sure?".localized(), message: "This will delete the activity forever".localized())
    }

    func deleteActivity() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        SelectedActivity.shared.activity = self.activity

        do {
            if let selectedActivity = SelectedActivity.shared.activity {
                appDelegate.persistentContainer.viewContext.delete(selectedActivity)
                selectedActivity.deletedDate = Date()
            }
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            print("Fetch failed")
        }

        ActivitiesObject.arrayOfActivities.remove(at: selectedIndexToDelete)
        navigationController?.popViewController(animated: true)
    }
}
