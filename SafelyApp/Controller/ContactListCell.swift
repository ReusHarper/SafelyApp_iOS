// ==================== Dependencies ====================
import UIKit

class ContactListCell: UITableViewCell {

    // ==================== Elements ====================
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var emailTextLabel: UILabel!

    // ==================== Methods ====================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(_ contact: ContactModel, _ indexPath: IndexPath) {
        nameTextLabel.text = contact.username
        emailTextLabel.text = contact.email
    }
    
}
