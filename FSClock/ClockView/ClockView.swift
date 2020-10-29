// ClockView.swift

import UIKit

@IBDesignable class ClockView: UIView {
    // MARK: Private variables
    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(displayLinkAction(displayLink:)))
    private let faceLayer = FaceLayer()
    private let hoursHandLayer = HoursHandLayer()
    private let minutesHandLayer = MinutesHandLayer()
    private let secondsHandLayer = SecondsHandLayer()
    private var started: Bool = false
    // MARK: Public variables
    public var paused: Bool { return self.displayLink.isPaused }
    public var smoothMoving: Bool = true
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    private func setup() {
        self.backgroundColor = .gray
        self.layer.masksToBounds = true
        self.layer.addSublayer(self.faceLayer)
        self.layer.addSublayer(self.hoursHandLayer)
        self.layer.addSublayer(self.minutesHandLayer)
        self.layer.addSublayer(self.secondsHandLayer)
        self.displayLink.preferredFramesPerSecond = 24
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.bounds.width/2
        self.faceLayer.frame = self.layer.bounds
        self.faceLayer.setNeedsDisplay()
        self.hoursHandLayer.frame = self.layer.bounds
        self.hoursHandLayer.setNeedsDisplay()
        self.minutesHandLayer.frame = self.layer.bounds
        self.minutesHandLayer.setNeedsDisplay()
        self.secondsHandLayer.frame = self.layer.bounds
        self.secondsHandLayer.setNeedsDisplay()
    }
    deinit {
        self.displayLink.invalidate()
    }
}

extension ClockView {
    // MARK: Public interface
    public func start() {
        if self.started == false {
            self.displayLink.add(to: .current, forMode: .default)
            self.started = true
        }
        if self.displayLink.isPaused {
            self.displayLink.isPaused = false
        }
    }
    public func pause() {
        self.displayLink.isPaused = true
    }
}

extension ClockView {
    // MARK: Actions
    @IBAction private func displayLinkAction(displayLink: CADisplayLink) {
        let currentTime = Date()
        let calendar = NSCalendar.current
        let hours = calendar.component(.hour, from: currentTime)
        let minutes = calendar.component(.minute, from: currentTime)
        let seconds = calendar.component(.second, from: currentTime)
        
        var hoursValue: CGFloat
        var minutesValue: CGFloat
        var secondsValue: CGFloat
        if smoothMoving {
            let timestamp: Double = currentTime.timeIntervalSince1970
            let milliseconds = timestamp - Double(Int(timestamp))
            secondsValue = CGFloat(Double(seconds) + milliseconds)
            minutesValue = CGFloat(minutes) + secondsValue/60
            hoursValue = CGFloat(hours) + minutesValue/60
        } else {
            hoursValue = CGFloat(hours)
            minutesValue = CGFloat(minutes)
            secondsValue = CGFloat(seconds)
        }
        if hoursValue != self.hoursHandLayer.hours {
            self.hoursHandLayer.hours = hoursValue
            self.hoursHandLayer.setNeedsDisplay()
        }
        if minutesValue != self.minutesHandLayer.minutes {
            self.minutesHandLayer.minutes = minutesValue
            self.minutesHandLayer.setNeedsDisplay()
        }
        if secondsValue != self.secondsHandLayer.seconds {
            self.secondsHandLayer.seconds = secondsValue
            self.secondsHandLayer.setNeedsDisplay()
        }
    }
}
