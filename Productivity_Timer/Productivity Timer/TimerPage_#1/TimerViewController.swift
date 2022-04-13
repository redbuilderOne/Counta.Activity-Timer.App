
import UIKit

class TimerViewController: UIViewController {

    let verticalLineView: UIImageView = {
        let verticalLineView = UIImageView()
        verticalLineView.image = veticalLine1
        verticalLineView.backgroundColor = .systemRed
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        return verticalLineView
    }()

    let elipseView: UIImageView = {
        let elipseView = UIImageView()
        elipseView.image = elipseSandyYellowColor
        elipseView.contentMode = .scaleAspectFit
//        elipseView.backgroundColor = .systemGray6
        elipseView.translatesAutoresizingMaskIntoConstraints = false
        return elipseView
    }()

    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "00:00"
        timerLabel.textAlignment = .center
        timerLabel.textColor = pinkyWhiteColor
        //      timerLabel.backgroundColor = .systemGray6
        timerLabel.font = .systemFont(ofSize: 45)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()

    //MARK: - Buttons
    let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.titleColor(for: .normal)
        startButton.tintColor = darkMoonColor
        startButton.backgroundColor = pinkyWhiteColor
        startButton.setTitleColor(darkMoonColor, for: .normal)
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.layer.cornerRadius = 12
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return startButton
    }()

    let stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setTitle("Stop", for: .normal)
        stopButton.titleColor(for: .normal)
        stopButton.tintColor = darkMoonColor
        stopButton.backgroundColor = pinkyWhiteColor
        stopButton.setTitleColor(darkMoonColor, for: .normal)
        stopButton.setImage(UIImage(systemName: "stop"), for: .normal)
        stopButton.layer.cornerRadius = 12
        stopButton.clipsToBounds = true
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return stopButton
    }()

    let setButton: UIButton = {
        let setButton = UIButton()
        setButton.setTitle("Set", for: .normal)
        setButton.titleColor(for: .normal)
        setButton.tintColor = darkMoonColor
        setButton.backgroundColor = pinkyWhiteColor
        setButton.setTitleColor(darkMoonColor, for: .normal)
        setButton.setImage(UIImage(systemName: "clock.arrow.2.circlepath"), for: .normal)
        setButton.layer.cornerRadius = 12
        setButton.clipsToBounds = true
        return setButton
    }()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = darkMoonColor
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(setButton)
        view.addSubview(elipseView)
        elipseView.addSubview(timerLabel)
        elipseView.addSubview(verticalLineView)
        verticalLineView.layer.opacity = 0.0
        placeButtons()
        placeTimerLabel()
        placeVerticalLineViewAtPosition1()
    }

    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }

    private func placeVerticalLineViewAtPosition1() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor, constant: -150),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func placeVerticalLineViewAtPosition2() {
        NSLayoutConstraint.activate([
            verticalLineView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 150),
            verticalLineView.centerYAnchor.constraint(equalTo: elipseView.safeAreaLayoutGuide.centerYAnchor),
            verticalLineView.heightAnchor.constraint(equalToConstant: 15),
            verticalLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func placeTimerLabel() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            timerLabel.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            elipseView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            elipseView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -75),
            elipseView.heightAnchor.constraint(equalToConstant: 300),
            elipseView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func placeButtons() {
        startButton.anchor(width: 250, height: 50)
        stopButton.anchor(width: 117, height: 50)
        setButton.anchor(width: 117, height: 50)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: elipseView.bottomAnchor, constant: 16),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            stopButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            setButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16),
            setButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor)
        ])
    }

    // MARK: - Animation
    private func animationCircular() {
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

    // MARK: - roundAnimation
    let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")

    private func startRoundAnimation() {
        roundAnimation.toValue = 0
        roundAnimation.duration = CFTimeInterval(60)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 999
        shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    private func resetRoundAnimation() {
        roundAnimation.toValue = roundAnimation.fromValue
        roundAnimation.duration = CFTimeInterval(0.5)
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        roundAnimation.repeatCount = 1
        shapeLayer.add(roundAnimation, forKey: "roundAnimation")
    }

    // MARK: - Timer
    var timer = Timer()
    var runCount = 0
    var durationCounter = 0
    var isTimerActivated = false
    var countdown = 0
    let shapeLayer = CAShapeLayer()

    // MARK: - start, pause, stop Timer
    private func startTimer() {
        print("timer starts")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

        startRoundAnimation()

        UIView.animate(withDuration: 1.0) {
            self.verticalLineView.layer.opacity = 1.0
        }
    }

    @objc func fireTimer() {
        let hours = countdown / 3600
        let minsec = countdown % 3600
        let minutes = minsec / 60
        let seconds = minsec % 60
        print(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
        countdown += 1
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        if hours == 1 {
            timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }

    @objc func pauseTimer() {
        timer.invalidate()
        resetRoundAnimation()
        //        isTimerActivated = false
    }

    @objc func stopButtonPressed() {
        pauseTimer()
        timerLabel.text = "00:00"
        setPlayImg()

        resetRoundAnimation()

        UIView.animate(withDuration: 1.0, delay: 1.0) {
            self.verticalLineView.layer.opacity = 0.0
        }
    }

    //MARK: - Обратный таймер
    private func setDurationTimer(setTimer: String) {
        durationCounter = Int(setTimer) ?? 0
    }

    //FOR SETTING THE TIMER
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    //            print("Timer fired!")
    //        }

    @objc func reverseTimer() {
        durationCounter -= 1

        if durationCounter == 0 {
            timer.invalidate()
        }
    }

    //MARK: TODO TIMER LOGIC IF/ELSE + SWITCH
    @objc func startButtonPressed() {
        print("startButton is pressed")
        isTimerActivated = true
        switch isTimerActivated {
        case true:
            startTimer()
            isTimerActivated = false
            setStopImg()
            print("isTimerActivated switched to \(isTimerActivated)")
        case false:
            isTimerActivated = true
            setPlayImg()
            print("isTimerActivated switched to \(isTimerActivated)")
        }
    }

    private func setPlayImg() {
        startButton.setTitle("Start", for: .normal)
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    private func setStopImg() {
        startButton.setTitle("Pause", for: .normal)
        startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        startButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
    }
}
