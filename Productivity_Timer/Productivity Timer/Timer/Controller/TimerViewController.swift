
import UIKit

class TimerViewController: UIViewController, TimerViewDelegate {

    var timerView = TimerView()
    let timerFormat = TimerFormat()
    var constants = LetsAndVarsForTimer()

    override func loadView() {
        view = timerView
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        timerView.delegate = self

        constants.startTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.START_TIME_KEY.rawValue) as? Date
        constants.stopTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.STOP_TIME_KEY.rawValue) as? Date
        constants.isTimerActivated = constants.userDefaults.bool(forKey: LetsAndVarsForTimer.Keys.COUNTING_KEY.rawValue)
        constants.countDownTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue) as? Date

        if constants.isTimerActivated {
            startTimer(action: #selector(refreshValue))
        } else {
            stopTimer()
            if let start = constants.startTime {
                if let stop = constants.stopTime {
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
        timerView.animateCircular()
        timerView.verticalLineView.layer.opacity = 0.0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Round Animation
    let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")

    func startRoundAnimation() {
        roundAnimation.toValue = 0
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 999
        timerView.shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    func resetRoundAnimation() {
        roundAnimation.toValue = roundAnimation.fromValue
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 1
        timerView.shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }
    
    //MARK: - startActionDidPressed
    func startActionDidPressed() {
        timerView.timerLabel.isHidden = false
        if constants.isTimerActivated {
            setStopTime(date: Date())
            stopTimer()
            setButtonImg(title: "Play", img: "play")
        } else {
            if let stop = constants.stopTime {
                let restartTime = countRestartTime(start: constants.startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            startTimer(action: #selector(refreshValue))
            setButtonImg(title: "Pause", img: "pause")
        }
    }

    private func countRestartTime(start: Date, stop: Date) -> Date {
        let difference = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(difference)
    }

    //MARK: - stopActionDidPressed
    func stopActionDidPressed() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        stopTimer()
        resetRoundAnimation()
        timerView.timerLabel.text = "Stop"
        timerView.timerLabel.isHidden = false
        timerView.startButton.isHidden = false
        timerView.startButton.isEnabled = true
        UIView.animate(withDuration: 3.0, delay: 2.0) {
            self.timerView.verticalLineView.layer.opacity = 0.0
        }
    }

    // MARK: - Start, Pause, Stop Timers
    private func setStartTime(date: Date?) {
        constants.startTime = date
        constants.userDefaults.set(constants.startTime, forKey: LetsAndVarsForTimer.Keys.START_TIME_KEY.rawValue)
    }

    private func setStopTime(date: Date?) {
        constants.stopTime = date
        constants.userDefaults.set(constants.stopTime, forKey: LetsAndVarsForTimer.Keys.STOP_TIME_KEY.rawValue)
        setButtonImg(title: "Play", img: "play")
    }

    private func setTimerCounting(_ val: Bool) {
        constants.isTimerActivated = val
        constants.userDefaults.set(constants.isTimerActivated, forKey: LetsAndVarsForTimer.Keys.COUNTING_KEY.rawValue)
    }

    func startTimer(action: Selector) {
        constants.scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: action, userInfo: nil, repeats: true)
        setTimerCounting(true)
        startRoundAnimation()
    }

    @objc func refreshValue() {
        if let start = constants.startTime {
            let differrence = Date().timeIntervalSince(start)
            setTimeLabel(Int(differrence))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }

    func stopTimer() {
        if constants.scheduledTimer != nil {
            constants.scheduledTimer.invalidate()
        }
        setTimerCounting(false)
        resetRoundAnimation()
    }

    private func setTimeLabel(_ val: Int) {
        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString
    }

    @objc func pauseTimer() {
        constants.timer.invalidate()
        resetRoundAnimation()
    }

    func setButtonImg(title: String, img: String) {
        timerView.startButton.setTitle(title, for: .normal)
        timerView.startButton.setImage(UIImage(systemName: img), for: .normal)
    }

    //MARK: - Обратный таймер
    func startSetTimerButtonDidPressed() {
        constants.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(beginCountDown), userInfo: nil, repeats: false)
    }

    func setActionDidPressed() {
        stopTimer()
        print("setActionDidPressed")
        timerView.timerLabel.isHidden = true
        timerView.timePickerView.isHidden = false
    }

    @objc func beginCountDown() {
        timerView.timerLabel.text = String(constants.countdown)

        setStopTime(date: nil)
        setStartTime(date: nil)

        if constants.countdown != 0.0 {
            setButtonImg(title: "Countdown", img: "")
            startRoundAnimation()
            constants.countdown -= 0.1
        } else {
            resetRoundAnimation()
            timerView.startButton.isEnabled = true
            timerView.timerLabel.text = "TIME'S UP"
            stopTimer()
        }
    }
}
