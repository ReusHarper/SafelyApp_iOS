// ==================== Dependencies ====================
import UIKit

class AddTabView: UIView {
    
    // ==================== General ====================
    
    // ==================== Labels ====================
    @IBOutlet var infoTextLabel: UILabel!
    
    // ==================== Inputs ====================
    @IBOutlet var emailTextField: UITextField!
    
    // ==================== Buttons ====================
    @IBOutlet var sendButton: GradientButtonUI!
    @IBOutlet var cancelButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit() {
        let xibView = Bundle.main.loadNibNamed("AddTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
}
