//
//  RequestListCell.swift
//  SafelyApp
//
//  Created by ReusHarper on 17/01/23.
//

import UIKit

class RequestListCell: UITableViewCell {
    
    // ==================== Elements ====================
    @IBOutlet var requestImageView: UIImageView!
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var emailTextLabel: UILabel!

    // ==================== Buttons ====================
    @IBOutlet var acceptButton: GradientButtonUI!
    @IBOutlet var deleteButton: GradientButtonUI!

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
    
    func initCustomElements() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        deleteButton.layer.borderWidth = 2.0
        deleteButton.layer.borderColor = borderColor?.cgColor
    }
}
