// ==================== Dependencies ====================
import CoreLocation
import FirebaseAuth
import FirebaseFirestore
import UIKit

class EmergencyViewController: UIViewController {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var timer = Timer()
    private var seconds = 5
    private var listContact: [String] = []
    internal var location: CLLocation = CLLocation()

    // ==================== Elements ====================
    @IBOutlet var countTextLabel: UILabel!
    @IBOutlet var cancelButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Location: \(String(describing: location))")
        initCustomElements()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(countdown),
            userInfo: nil,
            repeats: true
        )
        getListContact()
    }
    
    private func initCustomElements() {
        let borderColor = UIColor(named: "TertiaryColor")
        
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = borderColor?.cgColor
    }
    
    @objc private func countdown() {
        seconds -= 1
        
        if (seconds <= 0) {
            timer.invalidate()
            sendLocation()
            returnView()
        }
        countTextLabel.text = "\(seconds)"
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        returnView()
    }
    
    private func returnView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getListContact() {
        if let email = user?.email {
            let COLLECTION = "contact"
            
            database.collection(COLLECTION).document(String(email)).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, document.exists {
                    let data = document.data() as? [String: String]
                    for (_, value) in data! {
                        self.listContact.append(value)
                    }
                } else {
                    print("Error - obteniendo el documento")
                }
            }
            
        } else {
            print("Error - No fue posible conectarnos a la cuenta")
        }
    }
    
    private func sendLocation() {
        if let email = user?.email {
            let COLLECTION = "notifications"
            let _email = setEmailWithCorrectFormat(email: email)
            
            for (contact) in listContact {
                database.collection(COLLECTION).document(contact).getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = [email, GeoPoint(latitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude)]

                        self.database.collection(COLLECTION).document(contact).updateData([
                            //"alert_\(_email)": FieldValue.arrayUnion([data])
                            "alert_\(_email)": data
                        ])
                        { err in
                            if let err = err {
                                print("Error al añadir los campos en el documento: \(err)")
                            }
                        }
                    } else {
                        print("El archivo del usuario \(String(describing: email)) no existe dentro de la coleccion \(COLLECTION)")
                    }
                }
            }
        } else {
            print("Error de servicio - Envio de alerta de emergencia")
        }
    }
    
    private func setEmailWithCorrectFormat(email: String) -> String {
        var newEmail = ""
        for char in email {
            if char == "." {
                newEmail.append("_")
            } else {
                newEmail.append(char)
            }
        }
        print("Email: \(email)")
        print("New Email: \(newEmail)")
        return newEmail
    }
}
