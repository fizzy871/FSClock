// ViewController.swift

import UIKit

class ViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var clockView: ClockView!
    @IBOutlet private weak var switchView: UISwitch!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchView.isOn = self.clockView.smoothMoving
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.clockView.start()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.clockView.pause()
    }
}

extension ViewController {
    // MARK: Actions
    @IBAction private func switchAction(_ sender: UISwitch) {
        self.clockView.smoothMoving = sender.isOn
    }
}
