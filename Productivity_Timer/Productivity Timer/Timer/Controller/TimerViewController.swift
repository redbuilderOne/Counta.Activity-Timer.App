
import UIKit
import CoreData

final class TimerViewController: UIViewController, TimerViewDelegate {
    var activity: Activity?
    var timerView = TimerView()
    let timerFormat = TimerFormat()
    var constants = LetsAndVarsForTimer()
    let secFormat = SecondsPickerFormat()
    lazy var newActivityVC = NewActivityViewController()
    var focusTextLabelDidTapped = false
    lazy var focusCurrentText: String? = nil
    lazy var selectedIndexToDelete = Int()

    override func loadView() {
        view = timerView
    }

    init(activity: Activity? = nil) {
        self.activity = activity
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        timerView.delegate = self
        timerView.focusTextField.delegate = self

        constants.startTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.START_TIME_KEY.rawValue) as? Date
        constants.stopTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.STOP_TIME_KEY.rawValue) as? Date
        constants.isTimerActivated = constants.userDefaults.bool(forKey: LetsAndVarsForTimer.Keys.COUNTING_KEY.rawValue)
        constants.countDownTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue) as? Date

        checkIfTimerActivated()
//        focusActivityCheck()
        hideKeyboardWhenTappedAround(textToClear: timerView.focusLabel)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToDownSwipeGesture))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnFocusedActivity))

        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)

        timerView.focusLabel.addGestureRecognizer(tapGesture)
        timerView.focusTextField.addTarget(self, action: #selector(focusTextFieldAction), for: .editingChanged)
    }

    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timerView.animateCircular()
    }

    @objc func focusTextFieldAction(_ textField: UITextField) -> String {
        let newTextTyped = timerView.focusTextField.text

        if let newTextTyped = newTextTyped {
            focusCurrentText = newTextTyped
        } else {
            print("Error the textField is empty")
        }

        timerView.focusLabel.text = focusCurrentText
        return focusCurrentText ?? ""
    }

    func saveFocusActivityToCoreData() {
        focusTextLabelDidTapped = true
        focusActivityCheck()

        if focusCurrentText == "" {
            focusCurrentText = nil
            focusTextLabelDidTapped = false
            return

        } else {
            var duplicateIndex: Int?
            duplicateIndex = ActivitiesObject.arrayOfActivities.firstIndex(where: { $0.title == focusCurrentText})
            print("Found duplicate index: \(String(describing: duplicateIndex))")

            if duplicateIndex != nil {
                duplicateIndex = nil

                let alert = UIAlertController(title: "Sorry", message: "Activity already exists", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)

                print("Index \(String(describing: duplicateIndex)) cleared")
                focusTextLabelDidTapped = false
                return

            } else {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
                let newActivity = Activity(entity: entity!, insertInto: context)
                newActivity.id = ActivitiesObject.arrayOfActivities.count as NSNumber
                newActivity.title = focusCurrentText
                newActivity.fav = false
                newActivity.isDone = false
                newActivity.focusedActivityTitle = focusCurrentText
                newActivity.isFocused = true
                FocusedActivity.focusedActivityText = newActivity.title
                FocusedActivity.activity = newActivity
                print("Now Focused Activity is \(newActivity.title ?? "")")
                ActivitiesObject.arrayOfActivities.append(newActivity)

                FocusedActivityToPresent.focusedActivity = newActivity
                selectedIndexToDelete = newActivity.id as! Int

                do {
                    try context.save()
                    print("New activity \(newActivity.title ?? "") is created and being focused")
                } catch {
                    print("Can't save the context")
                }

                focusCurrentText = nil
                return
            }
        }
    }

    @objc func tapOnFocusedActivity(sender: UITapGestureRecognizer) {
        print("tap on activity")
        if let focusedActivity = FocusedActivityToPresent.focusedActivity {
            present(ActivityDetailedViewController(activity: focusedActivity, selectedIndexToDelete: selectedIndexToDelete), animated: true, completion: nil)
        }
    }

    func focusActivityCheck() {
        if focusTextLabelDidTapped != true {
            timerView.focusTextField.isHidden = true
            timerView.focusLabel.isHidden = false
            timerView.focusLabel.text = "tap to focus on activity"
            timerView.focusLabel.textColor = .systemGray
            timerView.focusLabel.layer.opacity = 0.1
        } else {
            timerView.focusLabel.isHidden = false
            timerView.focusTextField.isHidden = true
            timerView.focusLabel.text = focusCurrentText
            timerView.focusLabel.textColor = sandyYellowColor
            timerView.focusLabel.layer.opacity = 1
            view.setNeedsDisplay()
        }
    }















    // MARK: -TIMER
    private func checkIfTimerActivated() {
        if constants.isTimerActivated {
            startTimer(timeInterval: 0.1, action: #selector(refreshValue))
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

    @objc func respondToDownSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                present(newActivityVC, animated: true, completion: nil)
            default:
                break
            }
        }
    }

    // MARK: - Round Animation
    let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")

    func startStopAnimation(toValue: Int, repeatCount: Float) {
        roundAnimation.toValue = toValue
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = repeatCount
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
            startTimer(timeInterval: 0.1, action: #selector(refreshValue))
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
        startStopAnimation(toValue: 1, repeatCount: 1)
        timerView.timerLabel.text = "STOP"
        timerView.timerLabel.textColor = .systemRed
        timerView.timerLabel.isHidden = false
        timerView.timePickerView.isHidden = true
        timerView.startButton.isHidden = false
        timerView.startButton.isEnabled = true
    }

    // MARK: - Start, Pause, Stop Timers
    private func setStartTime(date: Date?) {
        constants.startTime = date
        constants.userDefaults.set(constants.startTime, forKey: LetsAndVarsForTimer.Keys.START_TIME_KEY.rawValue)
        timerView.timerLabel.textColor = .white
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

    func startTimer(timeInterval: TimeInterval, action: Selector) {
        constants.scheduledTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: action, userInfo: nil, repeats: true)
        setTimerCounting(true)
        startStopAnimation(toValue: 0, repeatCount: 999)
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
        startStopAnimation(toValue: 1, repeatCount: 1)
    }

    func setTimeLabel(_ val: Int) {
        let time = timerFormat.setSecondsToHoursMinutesToHours(val)
        let timeString = timerFormat.convertTimeToString(hour: time.0, min: time.1, sec: time.2)
        timerView.timerLabel.text = timeString
        FocusedActivity.activity?.timeSpentTracker = timeString
        print("timeSpentTracker = \(String(describing: FocusedActivity.activity?.timeSpentTracker))")
    }

    @objc func pauseTimer() {
        constants.timer.invalidate()
        startStopAnimation(toValue: 1, repeatCount: 1)
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
        timerView.timerLabel.isHidden = true
        timerView.timePickerView.isHidden = false
    }

    @objc func beginCountDown() {
        timerView.timerLabel.text = String(constants.countdown)
        timerView.timerLabel.textColor = .white

        if constants.countdown > 0 {
            setButtonImg(title: "Countdown", img: "")
            constants.countdown -= 1
        } else {
            constants.timer.invalidate()
            timerView.startButton.isEnabled = true
            timerView.timerLabel.text = "TIME'S UP"
            timerView.timerLabel.textColor = .systemRed
            setButtonImg(title: "Play", img: "play")
            stopTimer()
        }
    }
}
