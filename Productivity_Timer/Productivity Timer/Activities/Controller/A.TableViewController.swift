
import UIKit

class ActivityTableViewController: UITableViewController {

    lazy var objects: [Activity] = []
    lazy var identifier = CellsID.activityTableViewID
    lazy var newActivityView = NewActivityViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkMoonColor
        setupNavigationBar()
        self.tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: identifier)
    }

    private func setupNavigationBar() {
        self.title = "Activities"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewActivity))
        self.navigationItem.rightBarButtonItem = addItem
    }

    @objc func addNewActivity() {
        print("plus is pressed")
        show(newActivityView, sender: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        view.backgroundColor = darkMoonColor
    }

    @objc func cellDidTapped() {
        // TODO: - Переход по тапу на ячейку с активити на страницу подробности этого активити
        //        show(ActivityDetailedViewController(activity: ActivityModel), sender: self)
        //        present(ViewFirstPost(post: fourthPostFull), animated: true)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ActivitiesTableViewCell else { fatalError() }
        let object = objects[indexPath.row]
        cell.set(object: object)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellDidTapped))
        cell.backgroundColor = blueMoonlight
        cell.addGestureRecognizer(tapGesture)
        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }

    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }

    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.fav = !object.fav
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.fav ? .systemPurple : .systemGray
        action.image = object.fav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        if object.fav {
            object.fav = true
        } else {
            object.fav = false
        }
        return action
    }
}
