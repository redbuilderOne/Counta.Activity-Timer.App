
import UIKit

class TimerViewController: UIViewController {

    let elipseView: UIImageView = {
        let elipseView = UIImageView()
        elipseView.image = UIImage(named: "Elipse")
        elipseView.contentMode = .scaleAspectFit
//        elipseView.backgroundColor = .systemGray6
        elipseView.translatesAutoresizingMaskIntoConstraints = false
        return elipseView
    }()

    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "00:00"
        timerLabel.textAlignment = .center
        timerLabel.textColor = pinkyWhiteColor
//      timerLabel.backgroundColor = .systemGray6
        timerLabel.font = .systemFont(ofSize: 32)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()

    //MARK: - Buttons
    let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.titleColor(for: .normal)
        startButton.tintColor = darkMoonColor
        startButton.backgroundColor = pinkyWhiteColor
        startButton.setTitleColor(darkMoonColor, for: .normal)
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.layer.cornerRadius = 12
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return startButton
    }()

    let stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setTitle("Stop", for: .normal)
        stopButton.titleColor(for: .normal)
        stopButton.tintColor = darkMoonColor
        stopButton.backgroundColor = pinkyWhiteColor
        stopButton.setTitleColor(darkMoonColor, for: .normal)
        stopButton.setImage(UIImage(systemName: "stop"), for: .normal)
        stopButton.layer.cornerRadius = 12
        stopButton.clipsToBounds = true
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return stopButton
    }()

    let setButton: UIButton = {
        let setButton = UIButton()
        setButton.setTitle("Set", for: .normal)
        setButton.titleColor(for: .normal)
        setButton.tintColor = darkMoonColor
        setButton.backgroundColor = pinkyWhiteColor
        setButton.setTitleColor(darkMoonColor, for: .normal)
        setButton.setImage(UIImage(systemName: "clock.arrow.2.circlepath"), for: .normal)
        setButton.layer.cornerRadius = 12
        setButton.clipsToBounds = true
        return setButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = darkMoonColor
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(setButton)
        view.addSubview(elipseView)
        placeButtons()
        placeTimerLabel()
    }

    private func placeTimerLabel() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            elipseView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            elipseView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            elipseView.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            elipseView.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            elipseView.heightAnchor.constraint(equalToConstant: 300),
            elipseView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func placeButtons() {
        startButton.anchor(width: 250, height: 50)
        stopButton.anchor(width: 117, height: 50)
        setButton.anchor(width: 117, height: 50)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 16),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            stopButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            setButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            setButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor)
        ])
    }

    //MARK: TODO TIMER LOGIC IF/ELSE + SWITCH
    @objc func startButtonPressed() {
        print("startButton is pressed")
        isTimerActivated = true
        switch isTimerActivated {
        case true:
            startTimer()
            isTimerActivated = false
            setStopImg()
            print("isTimerActivated switched to \(isTimerActivated)")
        case false:
            isTimerActivated = true
            setPlayImg()
            print("isTimerActivated switched to \(isTimerActivated)")
        }
    }

    @objc func pauseTimer() {
        timer?.invalidate()
//        isTimerActivated = false
    }

    @objc func stopButtonPressed() {
        pauseTimer()
        timerLabel.text = "00:00"
        setPlayImg()
    }

    // MARK: - Timer
    var timer: Timer?
    var runCount = 0
    var isTimerActivated = false

    private func startTimer() {
        print("timer starts")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    @objc func fireTimer() {
        runCount += 1
        timerLabel.text = "00:0" + String(runCount)
        print("\(runCount)")

        //FOR SETTING THE TIMER
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            print("Timer fired!")
        //        }
    }

    private func setPlayImg() {
        startButton.setTitle("Start", for: .normal)
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    private func setStopImg() {
        startButton.setTitle("Pause", for: .normal)
        startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        startButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
    }
}
