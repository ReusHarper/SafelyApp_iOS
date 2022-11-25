import UIKit

class InputTextLabelUI: UITextField {
    
    let insets : UIEdgeInsets
    
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)) {
        self.insets = insets
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.lightGray.cgColor
        placeholder = "I'm a custom UIFieldText"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    /*
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.cornerCurve = .continuous
        }
    }
     */
    
}
