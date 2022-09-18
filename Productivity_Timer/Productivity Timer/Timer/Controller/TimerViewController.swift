
import UIKit
import CoreData

final class TimerViewController: UIViewController, TimerViewDelegate {
    let timerView = TimerView()
    let timerFormat = TimerFormat()
    var constants = LetsAndVarsForTimer()
    let newActivityViewController: NewActivityViewController
    var coreDataSaver: CoreDataSaver?
    var coreDataTimeSaver: CoreDataTimeSaver?
    var focusTextLabelDidTapped = false
    lazy var focusCurrentText: String? = nil
    var buttonDidPressedSwitcher = false

    override func loadView() {
        view = timerView
    }

    init(activity: Activity? = nil) {
        newActivityViewController = NewActivityViewController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        timerView.delegate = self
        timerView.focusTextField.delegate = self
        runUserDefaults()
        checkIfTimerActivated()
        hideKeyboardWhenTappedAround(textToClear: timerView.focusLabel)
        runSwiperDownSettings()
        firstLoadChecker()
        timerView.focusTextField.addTarget(self, action: #selector(focusTextFieldAction), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFocusedActivity()
        self.navigationController?.navigationBar.isHidden = true
    }

    func useAndDeleteCoreDataSaver(isViewAffected: Bool) {
        coreDataSaver = CoreDataSaver()
        coreDataSaver?.saveNewActivityToCoreData(controller: self, timerView: self.timerView)
        switch isViewAffected {
        case true:
            timerView.focusLabel.isHidden = false
            timerView.stopButtonPressed()
            timerView.timerLabel.text = "FOCUSED"
            timerView.timerLabel.textColor = pinkyWhiteColor
            timerView.focusTextField.text = ""
        default:
            print("view not affected")
            break
        }
        coreDataSaver = nil
    }

    private func runUserDefaults() {
        constants.startTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.START_TIME_KEY.rawValue) as? Date
        constants.stopTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.STOP_TIME_KEY.rawValue) as? Date
        constants.isTimerActivated = constants.userDefaults.bool(forKey: LetsAndVarsForTimer.Keys.COUNTING_KEY.rawValue)
        constants.countDownTime = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.SET_TIME_KEY.rawValue) as? Date
        constants.secondsToSave = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.SEC_TO_SAVE.rawValue) as? Date
        constants.minutesToSave = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.MIN_TO_SAVE.rawValue) as? Date
        constants.hoursToSave = constants.userDefaults.object(forKey: LetsAndVarsForTimer.Keys.HOURS_TO_SAVE.rawValue) as? Date
    }

    private func runSwiperDownSettings() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToDownSwipeGesture))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnFocusedActivity))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
        timerView.focusLabel.addGestureRecognizer(tapGesture)
    }

    private func firstLoadChecker() {
        var firstLoadChecker: FirstLoadCheck?
        firstLoadChecker = FirstLoadCheck()
        firstLoadChecker?.firstLoadCheck()
        firstLoadChecker = nil
    }

    private func checkFocusedActivity() {
        if let activity = SelectedActivity.shared.activity {
            switch activity.isFocused {
            case true:
                timerView.focusLabel.text = activity.title
                timerView.focusLabel.textColor = sandyYellowColor
                timerView.focusLabel.layer.opacity = 1
                timerView.focusTextField.isHidden = true
                timerView.focusLabel.isHidden = false
            case false:
                timerView.focusTextField.isHidden = false
                timerView.focusLabel.text = "tap to focus on activity"
                timerView.focusLabel.textColor = .systemGray
                timerView.focusLabel.layer.opacity = 0.3
                stopActionDidPressed()
                stopTimer()
            }
        }
    }

    @objc func respondToDownSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                present(newActivityViewController, animated: true, completion: nil)
            default:
                break
            }
        }
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

    @objc func tapOnFocusedActivity(sender: UITapGestureRecognizer) {
        print("tap on activity")
        self.navigationController?.navigationBar.isHidden = false
        if let focusedActivity = SelectedActivity.shared.activity {
            navigationController?.pushViewController(ActivityDetailedViewController(activity: focusedActivity, selectedIndexToDelete: SelectedActivity.shared.selectedIndexToDelete!), animated: true)
        }
    }

    func focusActivityCheck() {
        if focusTextLabelDidTapped != true {
            timerView.focusTextField.isHidden = true
            timerView.focusLabel.isHidden = false
            timerView.focusLabel.text = "tap to focus on activity"
            timerView.focusLabel.textColor = .systemGray
            timerView.focusLabel.layer.opacity = 0.3
        } else {
            timerView.focusLabel.isHidden = false
            timerView.focusTextField.isHidden = true
            timerView.focusLabel.text = focusCurrentText
            timerView.focusLabel.textColor = sandyYellowColor
            timerView.focusLabel.layer.opacity = 1
            view.setNeedsDisplay()
        }
    }

    // MARK: TIMER
    private func checkIfTimerActivated() {
        if constants.isTimerActivated {
            startTimer(timeInterval: 0.1, action: #selector(refreshValue))
            setButtonImg(title: "", img: "pause")
        } else {
            stopTimer()
            setButtonImg(title: "", img: "play")
            if let start = constants.startTime {
                if let stop = constants.stopTime {
                    let time = countRestartTime(start: start, stop: stop)
                    let difference = Date().timeIntervalSince(time)
                    setTimeLabel(Int(difference))
                }
            }
        }
    }

    func startActionDidPressed() {
        timerView.timerLabel.isHidden = false
        if constants.isTimerActivated {
            setStopTime(date: Date())
            stopTimer()
            setButtonImg(title: "", img: "play")
        } else {
            if let stop = constants.stopTime {
                let restartTime = countRestartTime(start: constants.startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            startTimer(timeInterval: 0.1, action: #selector(refreshValue))
            setButtonImg(title: "", img: "pause")
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
        timerView.timerLabel.text = "STOP"
        timerView.timerLabel.textColor = .systemRed
        timerView.timerLabel.isHidden = false
        timerView.startButton.isHidden = false
        timerView.startButton.isEnabled = true
    }

    private func setStartTime(date: Date?) {
        constants.startTime = date
        constants.userDefaults.set(constants.startTime, forKey: LetsAndVarsForTimer.Keys.START_TIME_KEY.rawValue)
        timerView.timerLabel.textColor = .white
    }

    private func setStopTime(date: Date?) {
        constants.stopTime = date
        constants.userDefaults.set(constants.stopTime, forKey: LetsAndVarsForTimer.Keys.STOP_TIME_KEY.rawValue)
        setButtonImg(title: "", img: "play")
    }

    private func setTimerCounting(_ val: Bool) {
        constants.isTimerActivated = val
        constants.userDefaults.set(constants.isTimerActivated, forKey: LetsAndVarsForTimer.Keys.COUNTING_KEY.rawValue)
    }

    private func startTimer(timeInterval: TimeInterval, action: Selector) {
        constants.scheduledTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: action, userInfo: nil, repeats: true)
        setTimerCounting(true)
        timerView.circleView.layer.addSublayer(timerView.circleView.roundShapeLayer)
        timerView.circleView.roundShapeLayer.isHidden = false
        buttonDidPressedSwitcher = true
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
            timerView.circleView.layer.removeAllAnimations()
            timerView.circleView.roundShapeLayer.isHidden = true
        }
        setTimerCounting(false)

        if buttonDidPressedSwitcher {
            buttonDidPressedSwitcher = false
            coreDataTimeSaver = CoreDataTimeSaver()
            guard let context = coreDataTimeSaver?.loadPersistentContainer() else { return }
            coreDataTimeSaver?.saveStackedTime(context: context, timerFormat: self.timerFormat)
            coreDataTimeSaver = nil
        }
    }
    
    private func setTimeLabel(_ val: Int) {
        coreDataTimeSaver = CoreDataTimeSaver()
        coreDataTimeSaver?.saveTime(timerFormat: self.timerFormat, val: val, timerView: self.timerView)
        coreDataTimeSaver = nil
    }

    @objc func pauseTimer() {
        constants.timer.invalidate()
        timerView.circleView.layer.removeAllAnimations()
        timerView.circleView.roundShapeLayer.isHidden = true
    }

    private func setButtonImg(title: String, img: String) {
        timerView.startButton.setTitle(title, for: .normal)
        timerView.startButton.setImage(UIImage(systemName: img), for: .normal)
    }
}
