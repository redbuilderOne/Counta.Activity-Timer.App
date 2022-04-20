
import UIKit

class ActivitiesViewController: UIViewController {

    let identifier = "ActivitiesViewController"

    lazy var newActivityCreationView = NewActivityCreationView()

    var objects = [
        Activity(img: nil, title: "Video Editing", description: "Edit video", isFavourite: false, timeSpent: "00:00:00")
    ]

    lazy var viewForAddingNewActivity: UIView = {
        let viewForAddingNewActivity = UIView()
        viewForAddingNewActivity.backgroundColor = sandyYellowColor
        viewForAddingNewActivity.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 70)
        viewForAddingNewActivity.translatesAutoresizingMaskIntoConstraints = false
        return viewForAddingNewActivity
    }()

    lazy var textFieldForNewActivity = ActivityTextField(textColor: pinkyWhiteColor, placeholder: "enter new activity title")

    private var activityText = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureGestureRecognizer()
        view.addSubview(viewForAddingNewActivity)
        viewForAddingNewActivity.addSubview(textFieldForNewActivity)
        textFieldForNewActivity.delegate = self
    }

    final private func configureView() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = sandyYellowColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        view.backgroundColor = darkMoonColor
    }

    private func configureUIElements() {

    }

    //MARK: - Swipe Down Gesture
    private func configureGestureRecognizer() {

        textFieldForNewActivity.addTarget(self, action: #selector(textFieldTapped), for: .touchUpInside)
//        textFieldForNewActivity.addTarget(self, action: #selector(textChanged), for: .editingChanged)

        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeGestureRecognizerDown.direction = .down

        let swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeGestureRecognizerUp.direction = .up

        view.addGestureRecognizer(swipeGestureRecognizerDown)
        view.addGestureRecognizer(swipeGestureRecognizerUp)
    }

    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        var frame = view.frame

        switch sender.direction {
        case .up:
            print("swipe up commited")
            frame.origin.y -= 70.0
        case .down:
            print("swipe down commited")
            frame.origin.y += 70.0
        default:
            break
        }

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

    @objc func textFieldTapped() {
        textFieldForNewActivity.returnKeyType = .done
        textFieldForNewActivity.autocapitalizationType = .words
        textFieldForNewActivity.autocorrectionType = .yes
    }

    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
        textFieldForNewActivity.addGestureRecognizer(tapGesture)
    }

    @objc func fingerTap() {
        print("fingerTap was called")
        textFieldForNewActivity.endEditing(true)
    }
//
//    @objc func textChanged(_ textField: UITextField) -> String {
//        let newTextTyped = activityText
//        if let newTextTyped = newTextTyped {
//            statusText = newTextTyped
//        } else {
//            print("Error")
//        }
//        return statusText
//    }
}


//
//func configureTapGesture() {
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
//    self.addGestureRecognizer(tapGesture)
//}
//
//@objc func statusTextChanged(_ textField: UITextField) -> String {
//    let newTextTyped = textField.text
//    if let newTextTyped = newTextTyped {
//        statusText = newTextTyped
//    } else {
//        print("Ошибка, нет статуса")
//    }
//    return statusText
//}
//
//

