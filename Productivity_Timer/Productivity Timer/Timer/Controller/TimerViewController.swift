
import UIKit

class TimerViewController: UIViewController {

    //MARK: - Buttons
    lazy var startButton = TimerControlButton(title: "Start", titleColor: darkMoonColor, tintColor: darkMoonColor, backgroundColor: pinkyWhiteColor,  systemImageName: "play.fill")
    lazy var stopButton = TimerControlButton(title: "Stop", titleColor: darkMoonColor, tintColor: darkMoonColor, backgroundColor: pinkyWhiteColor, systemImageName: "stop.fill")
    lazy var setButton = TimerControlButton(title: "Set", titleColor: darkMoonColor, tintColor: darkMoonColor, backgroundColor: pinkyWhiteColor, systemImageName: "clock.arrow.2.circlepath")


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
        CircularAnimator.animateCircular()
    }

    // MARK: - Constraints
    final private func placeVerticalLineViewAtPosition1() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor, constant: -150),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    final private func placeVerticalLineViewAtPosition2() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 150),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    final private func placeTimerLabel() {
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

    final private func placeButtons() {
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

        // MARK: - timerButton's actions
        startButton.addTarget(self, action: #selector(startPauseTimerButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
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
    
    // MARK: - Start, Pause, Stop Timers
    
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

    @objc func stopButtonPressed() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        timerLabel.text = TimerFormat.convertTimeToString(hour: 0, min: 0, sec: 0)
        stopTimer()
        resetRoundAnimation()
        UIView.animate(withDuration: 1.0, delay: 1.0) {
            verticalLineView.layer.opacity = 0.0
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
            verticalLineView.layer.opacity = 1.0
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
        let time = TimerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = TimerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerLabel.text = timeString
    }

    @objc func pauseTimer() {
        timer.invalidate()
        resetRoundAnimation()
    }

    //MARK: - Обратный таймер
    private func setDurationTimer(setTimer: String) {
        durationCounter = Int(setTimer) ?? 0
    }

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
