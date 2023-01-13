// ==================== Dependencies ====================
import UIKit

class RequestTabView: UIView {

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
        let xibView = Bundle.main.loadNibNamed("RequestTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }

}
