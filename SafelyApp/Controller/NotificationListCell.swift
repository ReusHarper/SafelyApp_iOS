// ==================== Dependencies ====================
import UIKit

class NotificationListCell: UITableViewCell {

    // ==================== Elements ====================
    @IBOutlet var titleAlertTextLabel: UILabel!
    @IBOutlet var infoAlertTextLabel: UILabel!
    @IBOutlet var iconAlertImage: UIImageView!
    
    // ==================== Button ====================
    @IBOutlet var deleteButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ notify: NotificationsModel) {
        titleAlertTextLabel.text = notify.username
        infoAlertTextLabel.text = notify.message
    }
    
    func initCustomElements() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        deleteButton.layer.borderWidth = 2.0
        deleteButton.layer.borderColor = borderColor?.cgColor
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        print("Alerta eliminada")
    }
    
}
