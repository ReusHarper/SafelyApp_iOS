// ==================== Dependencies ====================
import UIKit

class EmergencyViewController: UIViewController {
    
    // ==================== General ====================
    private var timer = Timer()
    private var seconds = 5

    // ==================== Elements ====================
    @IBOutlet var countTextLabel: UILabel!
    @IBOutlet var cancelButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()

        initCustomElements()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(countdown),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func initCustomElements() {
        let borderColor = UIColor(named: "TertiaryColor")
        
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = borderColor?.cgColor
    }
    
    @objc private func countdown() {
        seconds -= 1
        
        if (seconds <= 0) {
            timer.invalidate()
            returnView()
        }
        countTextLabel.text = "\(seconds)"
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        returnView()
    }
    
    private func returnView() {
        dismiss(animated: true, completion: nil)
    }

}
