
import UIKit

class TimerViewController: UIViewController, TimerViewDelegate {

    var timerView = TimerView()

    override func loadView() {
        view = timerView
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        timerView.delegate = self

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
        timerView.animateCircular()
    }

    // MARK: - Round Animation
    let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")

    func startRoundAnimationDidPressed() {
        roundAnimation.toValue = 0
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 999
        TimerView.shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    func resetRoundAnimationDidPressed() {
        roundAnimation.toValue = roundAnimation.fromValue
        roundAnimation.duration = CFTimeInterval(0.5)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 1
        TimerView.shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    func startActionDidPressed() {
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

    func stopActionDidPressed() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        stopTimer()
        resetRoundAnimationDidPressed()
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

    private func countRestartTime(start: Date, stop: Date) -> Date {
        let difference = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(difference)
    }

    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
//                setPauseImg()
        startRoundAnimationDidPressed()
//        UIView.animate(withDuration: 1.0) {
//            verticalLineView.layer.opacity = 1.0
//        }
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
        //        setPlayImg()
    }

    func setTimeLabel(_ val: Int) {
        let time = TimerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = TimerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        TimerView.timerLabel.text = timeString
    }

    @objc func pauseTimer() {
        timer.invalidate()
        resetRoundAnimationDidPressed()
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
