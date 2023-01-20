// ==================== Dependencies ====================
import UIKit

class SideMenuListCell: UITableViewCell {
    
    // ==================== General ====================
    private let mainColor = UIColor(named: "GradientPurpleColor")
    private let secondColor = UIColor(named: "GradientVioletColor")
    private let tertiaryColor = UIColor(named: "TertiaryColor")
    
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
        //backgroundColor = secondColor
    }

    func setData(options: optionMenu) {
        optionTextLabel.text = options.title
        optionImage.image = UIImage(named: options.image)
    }
    
}
