
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

        constants.startTime = constants.userDefaults.object(forKey: constants.START_TIME_KEY) as? Date
        constants.stopTime = constants.userDefaults.object(forKey: constants.STOP_TIME_KEY) as? Date
        constants.isTimerActivated = constants.userDefaults.bool(forKey: constants.COUNTING_KEY)

        if constants.isTimerActivated {
            startTimer()
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

    // MARK: - Round Animation
    let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")

    func startRoundAnimationDidPressed() {
        roundAnimation.toValue = 0
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 999
        timerView.shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    func resetRoundAnimationDidPressed() {
        roundAnimation.toValue = roundAnimation.fromValue
        roundAnimation.duration = CFTimeInterval(0.5)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 1
        timerView.shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    func startActionDidPressed() {
        if constants.isTimerActivated {
            setStopTime(date: Date())
            stopTimer()
            setPlayImg()
        } else {
            if let stop = constants.stopTime {
                let restartTime = countRestartTime(start: constants.startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            startTimer()
            setPauseImg()
        }
    }

    private func countRestartTime(start: Date, stop: Date) -> Date {
        let difference = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(difference)
    }

    func stopActionDidPressed() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        stopTimer()
        resetRoundAnimationDidPressed()
        timerView.timerLabel.text = timerFormat.convertTimeToString(hour: 0, min: 0, sec: 0)
        UIView.animate(withDuration: 1.0, delay: 1.0) {
            self.timerView.verticalLineView.layer.opacity = 0.0
        }
    }

    // MARK: - Start, Pause, Stop Timers
    private func setStartTime(date: Date?) {
        constants.startTime = date
        constants.userDefaults.set(constants.startTime, forKey: constants.START_TIME_KEY)
    }

    private func setStopTime(date: Date?) {
        constants.stopTime = date
        constants.userDefaults.set(constants.stopTime, forKey: constants.STOP_TIME_KEY)
        setPlayImg()
    }

    private func setTimerCounting(_ val: Bool) {
        constants.isTimerActivated = val
        constants.userDefaults.set(constants.isTimerActivated, forKey: constants.COUNTING_KEY)
    }

    private func startTimer() {
        constants.scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
        startRoundAnimationDidPressed()
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

    private func stopTimer() {
        if constants.scheduledTimer != nil {
            constants.scheduledTimer.invalidate()
        }
        setTimerCounting(false)
        resetRoundAnimationDidPressed()
    }

    private func setTimeLabel(_ val: Int) {
        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString
    }

    @objc func pauseTimer() {
        constants.timer.invalidate()
        resetRoundAnimationDidPressed()
    }

    final private func setPlayImg() {
        timerView.startButton.setTitle("Play", for: .normal)
        timerView.startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    final private func setPauseImg() {
        timerView.startButton.setTitle("Pause", for: .normal)
        timerView.startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
//    //MARK: - Обратный таймер
//    private func setDurationTimer(setTimer: String) {
//        durationCounter = Int(setTimer) ?? 0
//    }
//
//    @objc func reverseTimer() {
//        durationCounter -= 1
//
//        if durationCounter == 0 {
//            timer.invalidate()
//        }
//    }
}
