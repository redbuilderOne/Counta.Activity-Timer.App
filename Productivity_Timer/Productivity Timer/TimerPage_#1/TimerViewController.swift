
import UIKit

class TimerViewController: UIViewController {

    let verticalLineView: UIImageView = {
        let verticalLineView = UIImageView()
        verticalLineView.image = veticalLine1
        verticalLineView.backgroundColor = .systemRed
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        return verticalLineView
    }()

    let elipseView: UIImageView = {
        let elipseView = UIImageView()
        elipseView.image = elipseSandyYellowColor
        elipseView.contentMode = .scaleAspectFit
        elipseView.translatesAutoresizingMaskIntoConstraints = false
        return elipseView
    }()

    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "00:00:00"
        timerLabel.textAlignment = .center
        timerLabel.textColor = pinkyWhiteColor
        timerLabel.font = .systemFont(ofSize: 45)
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
        startButton.addTarget(self, action: #selector(startPauseTimerButton), for: .touchUpInside)
        return startButton
    }()

    let stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setTitle("Stop", for: .normal)
        stopButton.titleColor(for: .normal)
        stopButton.tintColor = darkMoonColor
        stopButton.backgroundColor = pinkyWhiteColor
        stopButton.setTitleColor(darkMoonColor, for: .normal)
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
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

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = darkMoonColor
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(setButton)
        view.addSubview(elipseView)
        elipseView.addSubview(timerLabel)
        elipseView.addSubview(verticalLineView)
        verticalLineView.layer.opacity = 0.0
        placeButtons()
        placeTimerLabel()
        placeVerticalLineViewAtPosition1()

        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        isTimerActivated = userDefaults.bool(forKey: COUNTING_KEY)

        if isTimerActivated {
            startTimer()
        } else {
            stopTimer()
            if let start = startTime {
                if let stop = stopTime {
                    let time = countRestartTime(start: start, stop: stop)
                    let difference = Date().timeIntervalSince(time)
                    setTimeLabel(Int(difference))
                }
            }
        }
    }
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }

    // MARK: - constraints
    private func placeVerticalLineViewAtPosition1() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor, constant: -150),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func placeVerticalLineViewAtPosition2() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 150),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func placeTimerLabel() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            timerLabel.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            elipseView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            elipseView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            elipseView.heightAnchor.constraint(equalToConstant: 300),
            elipseView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func placeButtons() {
        startButton.anchor(width: 250, height: 50)
        stopButton.anchor(width: 117, height: 50)
        setButton.anchor(width: 117, height: 50)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: elipseView.bottomAnchor, constant: 32),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            stopButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            setButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            setButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor)
        ])
    }

    // MARK: - Animation Circular
    private func animationCircular() {
        let center = CGPoint(x: elipseView.frame.width / 2, y: elipseView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.opacity = 1
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = sandyYellowColor.cgColor
        elipseView.layer.addSublayer(shapeLayer)
    }

    // MARK: - Round Animation
    let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")

    private func startRoundAnimation() {
        roundAnimation.toValue = 0
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 999
        shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    private func resetRoundAnimation() {
        roundAnimation.toValue = roundAnimation.fromValue
        roundAnimation.duration = CFTimeInterval(0.5)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 1
        shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    // MARK: - Variables & Constants
    var timer = Timer()
    var runCount = 0
    var durationCounter = 0
    var countdown = 0
    let shapeLayer = CAShapeLayer()
    var isTimerActivated = false
    var startTime: Date?
    var stopTime: Date?
    let userDefaults = UserDefaults.standard
    let START_TIME_KEY = "startTime"
    let STOP_TIME_KEY = "stopTime"
    let COUNTING_KEY = "countingKey"
    var scheduledTimer: Timer!

    // MARK: - setTimers
    private func setStartTime(date: Date?) {
        startTime = date
        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }

    private func setStopTime(date: Date?) {
        stopTime = date
        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }

    private func setTimerCounting(_ val: Bool) {
        isTimerActivated = val
        userDefaults.set(isTimerActivated, forKey: COUNTING_KEY)
    }

    // MARK: - Start, Pause, Stop Timers
    @objc func stopButtonPressed() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        timerLabel.text = timeToString(hour: 0, min: 0, sec: 0)
        stopTimer()
        resetRoundAnimation()
        UIView.animate(withDuration: 1.0, delay: 1.0) {
            self.verticalLineView.layer.opacity = 0.0
        }
    }

    @objc func startPauseTimerButton() {
        if isTimerActivated {
            setStopTime(date: Date())
            stopTimer()
        } else {
            startTimer()
        }
        if let stop = stopTime {
            let restartTime = countRestartTime(start: startTime!, stop: stop)
            setStopTime(date: nil)
            setStartTime(date: restartTime)
        } else {
            setStartTime(date: Date())
        }
    }

    private func countRestartTime(start: Date, stop: Date) -> Date {
        let difference = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(difference)
    }

    private func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
        setPauseImg()
        startRoundAnimation()
        UIView.animate(withDuration: 1.0) {
            self.verticalLineView.layer.opacity = 1.0
        }
    }

    @objc func refreshValue() {
        if let start = startTime {
            let differrence = Date().timeIntervalSince(start)
            setTimeLabel(Int(differrence))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }

    private func stopTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
        }
        setTimerCounting(false)
        setPlayImg()
    }

    private func setTimeLabel(_ val: Int) {
        let time = setSecondsToHoursMinutesToHours(val)
        let timeString = timeToString(hour: time.0, min: time.1, sec: time.2)
        timerLabel.text = timeString
    }

    private func setSecondsToHoursMinutesToHours(_ miliseconds: Int) -> (Int, Int, Int) {
        let hour = miliseconds / 3600
        let min = (miliseconds % 3600) / 60
        let sec = (miliseconds % 3600) % 60
        return (hour, min, sec)
    }

    private func timeToString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }

    @objc func pauseTimer() {
        timer.invalidate()
        resetRoundAnimation()
    }

    //MARK: - Обратный таймер
    private func setDurationTimer(setTimer: String) {
        durationCounter = Int(setTimer) ?? 0
    }

    //FOR SETTING THE TIMER
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    //            print("Timer fired!")
    //        }

    @objc func reverseTimer() {
        durationCounter -= 1

        if durationCounter == 0 {
            timer.invalidate()
        }
    }
    // MARK: - Set Buttons Images
    private func setPlayImg() {
        startButton.setTitle("Start", for: .normal)
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    private func setPauseImg() {
        startButton.setTitle("Pause", for: .normal)
        startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        startButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
    }
}
