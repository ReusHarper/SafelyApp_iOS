// ==================== Dependencies ====================
import UIKit

class AccountViewController: UIViewController {
    
    // ==================== General ====================
    
    // ==================== Elements ====================
    @IBOutlet var nameTextLabel: UITextField!
    @IBOutlet var emailTextLabel: UITextField!
    @IBOutlet var directionsTextLabel: UITextField!
    @IBOutlet var accountImage: UIImageView!

    
    @IBOutlet var acceptButton: GradientButtonUI!
    @IBOutlet var cancelButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
    }
    
    private func customInit() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = borderColor?.cgColor
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        print("Aceptar")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
