// ==================== Dependencies ====================
import UIKit

class RequestListCell: UITableViewCell {
    
    // ==================== Elements ====================
    @IBOutlet var requestImageView: UIImageView!
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var emailTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(_ request: RequestModel) {
        nameTextLabel.text = request.username
        emailTextLabel.text = request.email
    }
}
