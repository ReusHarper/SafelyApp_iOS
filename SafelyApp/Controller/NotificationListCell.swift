// ==================== Dependencies ====================
import UIKit
import CoreLocation
import FirebaseFirestore

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
        let data = notify.message
        
        if data is String {
            titleAlertTextLabel.text = "Solicitud de Contacto"
            infoAlertTextLabel.text = "El usuario \(data) le ha enviado una invitacion de contacto"
            iconAlertImage.image = UIImage(named: "contact.png")
        } else if data is [Any] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yy"
            let currentDate = dateFormatter.string(from: Date())
            dateFormatter.dateFormat = "HH:mm"
            let currentTime = dateFormatter.string(from: Date())

            var username : String = ""
            var location : CLLocation = CLLocation()
            
            let myArray = data as! [Any]
            for value in myArray {
                if value is String {
                    username = value as! String
                    print("Es un string: \(value)")
                } else if value is GeoPoint {
                    let geo = value as! GeoPoint
                    location = CLLocation(latitude: geo.latitude, longitude: geo.longitude)
                    print("Es un location: \(String(describing: location))")
                }
            }
            
            titleAlertTextLabel.text = "Emergencia"
            infoAlertTextLabel.text = "\(username) te ha enviado su ubicacion actual: [\(location.coordinate.latitude), \(location.coordinate.longitude)] a las \(currentTime) hrs. el dia \(currentDate)"
        }
    }
}
