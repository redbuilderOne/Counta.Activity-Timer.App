
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

    //MARK: - startActionDidPressed
    func startActionDidPressed() {
        timerView.timerLabel.isHidden = false
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

    //MARK: - stopActionDidPressed
    func stopActionDidPressed() {
        setStopTime(date: nil)
        setStartTime(date: nil)
        stopTimer()
        resetRoundAnimationDidPressed()
        timerView.timerLabel.text = "Stop"
        timerView.timerLabel.isHidden = false
        timerView.startButton.isHidden = false
        timerView.startSetTimerButton.isHidden = true
        timerView.timePickerTextField.isHidden = true
        UIView.animate(withDuration: 3.0, delay: 2.0) {
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

    private func setPlayImg() {
        timerView.startButton.setTitle("Play", for: .normal)
        timerView.startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    private func setPauseImg() {
        timerView.startButton.setTitle("Pause", for: .normal)
        timerView.startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }

    //MARK: - Обратный таймер
    func setActionDidPressed() {
        stopTimer()
        print("setActionDidPressed")
        timerView.timerLabel.isHidden = true
        timerView.timePickerTextField.isHidden = false
        timerView.timePickerView.isHidden = false
    }

    func setTimerChanged() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm:ss"

//        timerView.timerLabel.text = timerView.timePickerTextField.text
        timerView.timerLabel.isHidden = false
//        timerView.timerLabel.text =

//        let time =  timerFormat.setSecondsToHoursMinutesToHours()
//        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
//        timerView.timerLabel.text = timeString

//        constants.countdown = timerFormat.setSecondsToHoursMinutesToHours(dateFormat)
        
//        constants.startTime = dateFormat
//        setStartTime(date: Date?)
    }

    func startSetTimerDidPressed() {
        
    }

    @objc func countDownBegan() {
        constants.countdown -= 1

    }

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
//
//    {
//
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//    }
//
//
//
//    @objc func updateCounter() {
//        //example functionality
//        if counter > 0 {
//            print("\(counter) seconds to the end of the world")
//            counter -= 1
//        }
//    }

}

//extension TimerViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        timerView.timePickerTextField.resignFirstResponder()
//        return true
//    }
//}

//MARK: - Extensions
extension TimerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerFormatArray.count
    }
}

extension TimerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerFormatArray[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timerView.timerLabel.isHidden = false
        timerView.startButton.isHidden = true
        timerView.startSetTimerButton.isHidden = false

        if pickerFormatArray[row] != pickerFormatArray[11] {
            timerView.timerLabel.text = "00:\(pickerFormatArray[row]):00"
        } else {
            timerView.timerLabel.text = "01:00:00"
        }

        let time = timerFormat.setSecondsToHoursMinutesToHours(pickerFormatArray[row])
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString
    }
}

