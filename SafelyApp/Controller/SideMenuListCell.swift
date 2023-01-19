// ==================== Dependencies ====================
import UIKit

class SideMenuListCell: UITableViewCell {
    
    // ==================== Elements ====================
    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionTextLabel: UILabel!
    
    // ==================== Methods ====================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(options: optionMenu) {
        optionTextLabel.text = options.title
        optionImage.image = UIImage(named: options.image)
    }
    
}
