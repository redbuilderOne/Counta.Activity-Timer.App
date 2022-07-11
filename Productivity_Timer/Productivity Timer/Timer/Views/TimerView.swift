
import UIKit

protocol TimerViewDelegate: AnyObject {
    func startActionDidPressed()
    func stopActionDidPressed()
}

class TimerView: UIView {
    weak var delegate: TimerViewDelegate?
    lazy var pulsingView = CircleView()

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
        self.addSubview(pulsingView)
        self.addSubview(focusLabel)
        self.addSubview(focusTextField)
        pulsingView.addSubview(timerLabel)
        pulsingView.translatesAutoresizingMaskIntoConstraints = false
        placeButtons()
        placeTimerLabel()
        configureButtonsAction()
    }

    // MARK: -protocol delegate
    @objc func startPauseTimerButton() {
        delegate?.startActionDidPressed()
        pulsingView.layer.addSublayer(pulsingView.roundShapeLayer)
        pulsingView.roundShapeLayer.isHidden = false
    }

    @objc func stopButtonPressed() {
        delegate?.stopActionDidPressed()
        pulsingView.layer.removeAllAnimations()
        pulsingView.roundShapeLayer.isHidden = true
    }

    @objc func endTimePickerEditing() {
        self.endEditing(true)
    }

    // MARK: -Constraints
    final private func placeTimerLabel() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            timerLabel.trailingAnchor.constraint(equalTo: pulsingView.trailingAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: pulsingView.leadingAnchor),

            pulsingView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            pulsingView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            pulsingView.heightAnchor.constraint(equalToConstant: 300),
            pulsingView.widthAnchor.constraint(equalToConstant: 300),

            focusLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            focusLabel.bottomAnchor.constraint(equalTo: pulsingView.topAnchor, constant: -32),
            focusLabel.heightAnchor.constraint(equalToConstant: 50),
            focusLabel.trailingAnchor.constraint(equalTo: pulsingView.trailingAnchor),
            focusLabel.leadingAnchor.constraint(equalTo: pulsingView.leadingAnchor),

            focusTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            focusTextField.bottomAnchor.constraint(equalTo: pulsingView.topAnchor, constant: -32),
            focusTextField.heightAnchor.constraint(equalToConstant: 50),
            focusTextField.trailingAnchor.constraint(equalTo: pulsingView.trailingAnchor),
            focusTextField.leadingAnchor.constraint(equalTo: pulsingView.leadingAnchor)
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
            startButton.topAnchor.constraint(equalTo: pulsingView.bottomAnchor),
            startButton.leadingAnchor.constraint(equalTo: pulsingView.leadingAnchor),
            stopButton.topAnchor.constraint(equalTo: pulsingView.bottomAnchor),
            stopButton.trailingAnchor.constraint(equalTo: pulsingView.trailingAnchor),
        ])
    }
}
