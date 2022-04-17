
import UIKit

class ActivitiesViewController: UIViewController {

    let identifier = "ActivitiesViewController"

    lazy var newActivityCreationView = NewActivityCreationView()

    var objects = [
        Activity(img: nil, name: "Video Editing", description: "Edit video", isFavourite: false, timeSpent: "00:00:00")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureGestureRecognizer()
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        view.backgroundColor = darkMoonColor
    }

    //MARK: - Swipe Down Gesture
    private func configureGestureRecognizer() {
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
        swipeGestureRecognizerDown.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizerDown)
    }

    @objc func didSwipeDown(_ sender: UISwipeGestureRecognizer) {
        print("swipe down commited")
        var frame = view.frame
        frame.origin.y += 100.0

        UIView.animate(withDuration: 0.25) {
            self.view.frame = frame
        }
    }

    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: ActivitiesTableViewCellID)
        return tableView
    }()
}
