
import UIKit

protocol TimerViewDelegate: AnyObject {
    func startActionDidPressed()
    func stopActionDidPressed()
    func setActionDidPressed()
    func startRoundAnimationDidPressed()
    func resetRoundAnimationDidPressed()
    func setTimerChanged()
}

class TimerView: UIView {

    weak var delegate: TimerViewDelegate?

    lazy var elipseView: UIImageView = {
        let elipseView = UIImageView()
        elipseView.image = elipseSandyYellowColor
        elipseView.contentMode = .scaleAspectFit
        elipseView.translatesAutoresizingMaskIntoConstraints = false
        return elipseView
    }()

    lazy var verticalLineView: UIImageView = {
        let verticalLineView = UIImageView()
        verticalLineView.image = veticalLine1
        verticalLineView.backgroundColor = .systemRed
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        return verticalLineView
    }()

    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "Hello"
        timerLabel.textAlignment = .center
        timerLabel.textColor = pinkyWhiteColor
        timerLabel.font = .systemFont(ofSize: 45)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()

    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer

//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endTimePickerEditing))
//        let addSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        toolbar.setItems([addSpace, doneButton], anima ted: true)

        return timePicker
    }()

    @objc func endTimePickerEditing() {
        self.endEditing(true)
    }

    lazy var timePickerTextField: UITextField = {
        let timePickerTextField = UITextField()
        timePickerTextField.placeholder = "enter timer value"
        timePickerTextField.font = .systemFont(ofSize: 32)
        timePickerTextField.textColor = pinkyWhiteColor
        timePickerTextField.textAlignment = .center
        timePickerTextField.translatesAutoresizingMaskIntoConstraints = false
        timePickerTextField.inputView = timePicker
        timePickerTextField.addTarget(self, action: #selector(timerValueChanged), for: .valueChanged)
//        timePickerTextField.delegate = delegate as? UITextFieldDelegate
        return timePickerTextField
    }()

    //MARK: - Buttons
    lazy var startButton = TimerControlButton(title: "Start", titleColor: darkMoonColor, tintColor: darkMoonColor, backgroundColor: pinkyWhiteColor,  systemImageName: "play.fill")
    lazy var stopButton = TimerControlButton(title: "Stop", titleColor: darkMoonColor, tintColor: darkMoonColor, backgroundColor: pinkyWhiteColor, systemImageName: "stop.fill")
    lazy var setButton = TimerControlButton(title: "Set", titleColor: darkMoonColor, tintColor: darkMoonColor, backgroundColor: pinkyWhiteColor, systemImageName: "clock.arrow.2.circlepath")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButtonsAction() {
        startButton.addTarget(self, action: #selector(startPauseTimerButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        setButton.addTarget(self, action: #selector(setButtonPressed), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = darkMoonColor
        self.addSubview(startButton)
        self.addSubview(stopButton)
        self.addSubview(setButton)
        self.addSubview(elipseView)
        self.addSubview(timePickerTextField)
        elipseView.addSubview(timerLabel)
        elipseView.addSubview(verticalLineView)
        timePickerTextField.isHidden = true
        placeButtons()
        placeTimerLabel()
        placeVerticalLineViewAtPosition1()
        configureButtonsAction()
    }

    // MARK: - protocol TimerViewDelegate
    @objc func startPauseTimerButton() {
        delegate?.startActionDidPressed()
    }

    @objc func stopButtonPressed() {
        delegate?.stopActionDidPressed()
    }

    @objc func setButtonPressed() {
        delegate?.setActionDidPressed()
    }

    func startRoundAnimation() {
        delegate?.startRoundAnimationDidPressed()
    }

    func resetRoundAnimation() {
        delegate?.resetRoundAnimationDidPressed()
    }

    @objc func timerValueChanged() {
        delegate?.setTimerChanged()
    }

    //MARK: - Circular ANIMATION
    let shapeLayer = CAShapeLayer()

    func animateCircular() {
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

    // MARK: - Constraints
    final private func placeVerticalLineViewAtPosition1() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor, constant: -150),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    final private func placeVerticalLineViewAtPosition2() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 150),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    final private func placeTimerLabel() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            timerLabel.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            elipseView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            elipseView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            elipseView.heightAnchor.constraint(equalToConstant: 300),
            elipseView.widthAnchor.constraint(equalToConstant: 300),
            timePickerTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            timePickerTextField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            timePickerTextField.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timePickerTextField.leadingAnchor.constraint(equalTo: startButton.leadingAnchor)
        ])
    }

    final private func placeButtons() {
        startButton.anchor(width: 250, height: 50)
        stopButton.anchor(width: 117, height: 50)
        setButton.anchor(width: 117, height: 50)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: elipseView.bottomAnchor, constant: 32),
            startButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            stopButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            setButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            setButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor)
        ])
    }
}
