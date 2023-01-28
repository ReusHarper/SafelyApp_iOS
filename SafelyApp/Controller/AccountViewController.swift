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
        
        nameTextLabel.delegate = self
        emailTextLabel.delegate = self
        directionsTextLabel.delegate = self
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        print("Aceptar")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    private func sendRequest(emailOwner: String, emailRequest: String) {
//        let collection = "request"
//        let _emailOwner = setEmailWithCorrectFormat(email: emailOwner)
//
//        if (user?.email) != nil {
//            database.collection(collection).document(emailRequest).getDocument { (document, error) in
//                if let document = document, document.exists {
//                    self.database.collection(collection).document(emailOwner).setData(["email_\(_emailOwner)": emailOwner]) { err in
//                        if let err = err {
//                            print("Error al añadir el campo en el documento: \(err)")
//                            self.alerts.message(
//                                title: "Error de servicio - Actualización de información de perfil",
//                                message: "Por el momento contamos con problemas con nuestros servidores, por favor espere unos momentos y vuelva a intentarlo más tarde."
//                            )
//                        }
//                        self.alerts.message(
//                            title: "Información actualizada",
//                            message: "Los datos ingresados se actualizaron en su cuenta exitosamente"
//                        )
//                    }
//                } else {
//                    self.alerts.message(
//                        title: "Usuario no encontrado",
//                        message: "Es posible que el usuario con el email proporcionado se encuentre en mal escrito o no este registrado en nuestros servidores, por favor verifique y vuelva a intentarlo."
//                    )
//                    print("El archivo del usuario \(emailRequest) no existe dentro de la coleccion \(collection)")
//                }
//            }
//        }
//        else {
//            alerts.message(
//                title: "Error de servicio - Conexión fallida",
//                message: "Por el momento contamos con problemas con nuestros servidores, por favor espere unos momentos y vuelva a intentarlo más tarde."
//            )
//        }
//    }
    
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
