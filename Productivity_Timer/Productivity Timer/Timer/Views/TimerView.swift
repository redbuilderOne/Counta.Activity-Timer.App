
import UIKit

protocol TimerViewDelegate: AnyObject {
    func startActionDidPressed()
    func stopActionDidPressed()
}

class TimerView: UIView {
    weak var delegate: TimerViewDelegate?

    lazy var focusLabel: UILabel = {
        let focusLabel = UILabel()
        focusLabel.textColor = .systemGray
        focusLabel.textAlignment = .center
        focusLabel.layer.cornerRadius = 12
        focusLabel.clipsToBounds = true
        focusLabel.font = .boldSystemFont(ofSize: 18)
        focusLabel.translatesAutoresizingMaskIntoConstraints = false
        focusLabel.isUserInteractionEnabled = true
        return focusLabel
    }()

    lazy var focusTextField: UITextField = {
        let focusTextField = UITextField()
        focusTextField.textColor = pinkyWhiteColor
        focusTextField.textAlignment = .center
        focusTextField.layer.cornerRadius = 12
        focusTextField.clipsToBounds = true
        focusTextField.font = .boldSystemFont(ofSize: 18)
        focusTextField.translatesAutoresizingMaskIntoConstraints = false
        focusTextField.isUserInteractionEnabled = true
        focusTextField.returnKeyType = .done
        return focusTextField
    }()

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

    //MARK: -Buttons
    lazy var startButton = TimerControlButton(title: "", titleColor: .systemGreen, tintColor: .systemGreen, backgroundColor: darkMoonColor,  systemImageName: "play")
    lazy var stopButton = TimerControlButton(title: "", titleColor: .systemRed, tintColor: .systemRed, backgroundColor: darkMoonColor, systemImageName: "stop")

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
        self.addSubview(elipseView)
        self.addSubview(focusLabel)
        self.addSubview(focusTextField)
        elipseView.addSubview(timerLabel)
        placeButtons()
        placeTimerLabel()
        configureButtonsAction()
    }

    // MARK: -protocol delegate
    @objc func startPauseTimerButton() {
        delegate?.startActionDidPressed()
    }

    @objc func stopButtonPressed() {
        delegate?.stopActionDidPressed()
    }

    @objc func endTimePickerEditing() {
        self.endEditing(true)
    }

    //MARK:  Circular ANIMATION
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
        shapeLayer.strokeColor = pinkyWhiteColor.cgColor
        elipseView.layer.addSublayer(shapeLayer)
    }

    // MARK: -Constraints
    final private func placeTimerLabel() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            timerLabel.trailingAnchor.constraint(equalTo: elipseView.trailingAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: elipseView.leadingAnchor),
            elipseView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            elipseView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            elipseView.heightAnchor.constraint(equalToConstant: 300),
            elipseView.widthAnchor.constraint(equalToConstant: 300),

            focusLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            focusLabel.bottomAnchor.constraint(equalTo: elipseView.topAnchor, constant: -32),
            focusLabel.heightAnchor.constraint(equalToConstant: 50),
            focusLabel.trailingAnchor.constraint(equalTo: elipseView.trailingAnchor),
            focusLabel.leadingAnchor.constraint(equalTo: elipseView.leadingAnchor),

            focusTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            focusTextField.bottomAnchor.constraint(equalTo: elipseView.topAnchor, constant: -32),
            focusTextField.heightAnchor.constraint(equalToConstant: 50),
            focusTextField.trailingAnchor.constraint(equalTo: elipseView.trailingAnchor),
            focusTextField.leadingAnchor.constraint(equalTo: elipseView.leadingAnchor)
        ])
    }

    //MARK: -Buttons Configuration
    private func configureButtonsAction() {
        startButton.addTarget(self, action: #selector(startPauseTimerButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
    }

    final private func placeButtons() {
        startButton.anchor(width: 100, height: 50)
        stopButton.anchor(width: 100, height: 50)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: elipseView.bottomAnchor),
            startButton.leadingAnchor.constraint(equalTo: elipseView.leadingAnchor),
            stopButton.topAnchor.constraint(equalTo: elipseView.bottomAnchor),
            stopButton.trailingAnchor.constraint(equalTo: elipseView.trailingAnchor),
        ])
    }
}
