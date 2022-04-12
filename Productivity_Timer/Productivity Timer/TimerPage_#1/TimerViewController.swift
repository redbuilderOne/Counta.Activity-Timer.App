
import UIKit

class TimerViewController: UIViewController {

    let startButton: UIButton = {
        let startButton = UIButton()
        startButton.layer.cornerRadius = 12
        startButton.setTitle("Start", for: .normal)
        startButton.titleColor(for: .normal)
        startButton.configuration?.baseBackgroundColor = sandyYellowColor
        startButton.backgroundColor = greenGrassColor
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.setTitleColor(darkMoonColor, for: .normal)
        return startButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = darkMoonColor
        view.addSubview(startButton)
        configureStartButton()
    }

    private func configureStartButton() {
        startButton.anchor(width: 250, height: 50)

        NSLayoutConstraint.activate([
//            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            startButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
//            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -240)
        ])
    }

    @objc func startButtonPressed() {
        print("startButton is pressed")
    }
}
