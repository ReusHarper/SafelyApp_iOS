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
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        customInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emailTextField.delegate = self
    }
    
    private func viewInit() {
        let xibView = Bundle.main.loadNibNamed("AddTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    private func customInit() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = borderColor?.cgColor
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        emailTextField.text = ""
        //UIViewController.showToast(message: "", font: .systemFont(ofSize: 12.0))
    }
}

extension AddTabView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//extension UIViewController {
//    func showToast (message: String, font: UIFont) {
//        let toastLabel = UILabel (frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 100, width: 150, height: 35))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor .white
//        toastLabel.font = font
//        toastLabel.textAlignment = .center
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10
//        toastLabel.clipsToBounds = true
//        self.view.addSubview (toastLabel)
//        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn,
//                       animations: {
//            toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
//}
