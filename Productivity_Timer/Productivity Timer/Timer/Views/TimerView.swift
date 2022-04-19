
import UIKit

protocol TimerViewDelegate: AnyObject {
    func startActionDidPressed()
    func stopActionDidPressed()
    func startRoundAnimationDidPressed()
    func resetRoundAnimationDidPressed()
}

class TimerView: UIView {

    weak var delegate: TimerViewDelegate?

    let elipseView: UIImageView = {
        let elipseView = UIImageView()
        elipseView.image = elipseSandyYellowColor
        elipseView.contentMode = .scaleAspectFit
        elipseView.translatesAutoresizingMaskIntoConstraints = false
        return elipseView
    }()

    var verticalLineView: UIImageView = {
        let verticalLineView = UIImageView()
        verticalLineView.image = veticalLine1
        verticalLineView.backgroundColor = .systemRed
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        return verticalLineView
    }()

    static var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "Hello"
        timerLabel.textAlignment = .center
        timerLabel.textColor = pinkyWhiteColor
        timerLabel.font = .systemFont(ofSize: 45)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
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
        setButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = darkMoonColor
        self.addSubview(startButton)
        self.addSubview(stopButton)
        self.addSubview(setButton)
        self.addSubview(elipseView)
        elipseView.addSubview(TimerView.timerLabel)
        elipseView.addSubview(verticalLineView)
        verticalLineView.layer.opacity = 0.0
        placeButtons()
        placeTimerLabel()
        placeVerticalLineViewAtPosition1()
        configureButtonsAction()
    }

    // MARK: - Start/Pause Actions
    @objc func startPauseTimerButton() {
        delegate?.startActionDidPressed()
        startButton.setTitle("Pause", for: .normal)
        startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }

    @objc func stopButtonPressed() {
        delegate?.stopActionDidPressed()
        TimerView.timerLabel.text = TimerFormat.convertTimeToString(hour: 0, min: 0, sec: 0)
        UIView.animate(withDuration: 1.0, delay: 1.0) {
            self.verticalLineView.layer.opacity = 0.0
        }
        startButton.setTitle("Start", for: .normal)
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    func startRoundAnimation() {
        delegate?.startRoundAnimationDidPressed()
        UIView.animate(withDuration: 1.0) {
            self.verticalLineView.layer.opacity = 1.0
        }
    }

    func resetRoundAnimation() {
        delegate?.resetRoundAnimationDidPressed()
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
            TimerView.timerLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            TimerView.timerLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            TimerView.timerLabel.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            TimerView.timerLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            elipseView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            elipseView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -75),
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
            startButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            stopButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            setButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            setButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor)
        ])
    }

    //MARK: - Circular ANIMATION
    static let shapeLayer = CAShapeLayer()

    func animateCircular() {
        let center = CGPoint(x: elipseView.frame.width / 2, y: elipseView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        TimerView.shapeLayer.opacity = 1
        TimerView.shapeLayer.path = circularPath.cgPath
        TimerView.shapeLayer.lineWidth = 1
        TimerView.shapeLayer.fillColor = UIColor.clear.cgColor
        TimerView.shapeLayer.strokeEnd = 1
        TimerView.shapeLayer.lineCap = CAShapeLayerLineCap.round
        TimerView.shapeLayer.strokeColor = sandyYellowColor.cgColor
        elipseView.layer.addSublayer(TimerView.shapeLayer)
    }
}
