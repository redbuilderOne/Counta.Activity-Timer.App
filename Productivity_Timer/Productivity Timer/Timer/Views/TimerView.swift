
import UIKit

protocol TimerViewDelegate: AnyObject {
    func startActionDidPressed()
    func stopActionDidPressed()
    func setActionDidPressed()
    func startSetTimerButtonDidPressed()
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

    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "Hello"
        timerLabel.textAlignment = .center
        timerLabel.textColor = pinkyWhiteColor
        timerLabel.font = .systemFont(ofSize: 45)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()

    lazy var setTimerLabel: UILabel = {
        let setTimerLabel = UILabel()
        setTimerLabel.text = ""
        setTimerLabel.textAlignment = .center
        setTimerLabel.textColor = pinkyWhiteColor
        setTimerLabel.font = .systemFont(ofSize: 64)
        setTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        return setTimerLabel
    }()

    lazy var timePickerView: UIPickerView = {
        let timePickerView = UIPickerView()
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.dataSource = delegate as? UIPickerViewDataSource
        timePickerView.delegate = delegate as? UIPickerViewDelegate
        return timePickerView
    }()

    @objc func endTimePickerEditing() {
        self.endEditing(true)
    }

    //MARK: - Buttons
    lazy var startButton = TimerControlButton(title: "Start", titleColor: .systemGreen, tintColor: .systemGreen, backgroundColor: blueMoonlight,  systemImageName: "play")
    lazy var stopButton = TimerControlButton(title: "Stop", titleColor: .systemRed, tintColor: .systemRed, backgroundColor: blueMoonlight, systemImageName: "stop")
    lazy var setButton = TimerControlButton(title: "Set", titleColor: .systemBlue, tintColor: .systemBlue, backgroundColor: blueMoonlight, systemImageName: "clock.arrow.2.circlepath")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = darkMoonColor
        self.addSubview(startButton)
        self.addSubview(stopButton)
        self.addSubview(setButton)
        self.addSubview(elipseView)
        self.addSubview(timePickerView)
        elipseView.addSubview(timerLabel)
        timePickerView.isHidden = true
        placeButtons()
        placeTimerLabel()
        configureButtonsAction()
    }

    // MARK: - protocol delegate
    @objc func startPauseTimerButton() {
        delegate?.startActionDidPressed()
    }

    @objc func stopButtonPressed() {
        delegate?.stopActionDidPressed()
    }

    @objc func setButtonPressed() {
        delegate?.setActionDidPressed()
    }

    @objc func startSetTimerButtonPressed() {
        delegate?.startSetTimerButtonDidPressed()
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
            timePickerView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            timePickerView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            timePickerView.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timePickerView.leadingAnchor.constraint(equalTo: startButton.leadingAnchor)
        ])
    }

    //MARK: - Buttons Configuration
    private func configureButtonsAction() {
        startButton.addTarget(self, action: #selector(startPauseTimerButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        setButton.addTarget(self, action: #selector(setButtonPressed), for: .touchUpInside)
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
