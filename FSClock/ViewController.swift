// ViewController.swift

import UIKit

class ViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var clockView: ClockView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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

