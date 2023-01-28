// ==================== Dependencies ====================
import FirebaseAuth
import FirebaseFirestore
import UIKit

class AddTabView: UIView {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var viewController: UIViewController?
    
    // ==================== Labels ====================
    @IBOutlet var infoTextLabel: UILabel!
    
    // ==================== Inputs ====================
    @IBOutlet var emailTextField: UITextField!
    
    // ==================== Buttons ====================
    @IBOutlet var sendButton: GradientButtonUI!
    @IBOutlet var cancelButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        customInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emailTextField.delegate = self
        //self.parentViewController = AddGroupViewController()
        self.viewController = self.parentViewController()
    }
    
    private func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    private func viewInit() {
        let xibView = Bundle.main.loadNibNamed("AddTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    private func customInit() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = borderColor?.cgColor
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        emailTextField.text = ""
    }
    
    @IBAction func sendAction(_ sender: Any) {
        sendRequest(emailOwner: user?.email, emailRequest: String(emailTextField.text!))
    }
    
    private func sendRequest(emailOwner: String?, emailRequest: String) {
        if (emailOwner) != nil {
            let collection = "request"
            let _emailOwner = setEmailWithCorrectFormat(email: emailOwner!)

            database.collection(collection).document(emailRequest).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.database.collection(collection).document(emailRequest).setData(["email_\(_emailOwner)": emailOwner!]) { err in
                        if let err = err {
                            print("Error al añadir el campo en el documento: \(err)")
                            self.showAlert(
                                title: "Error de servicio - Envio de solicitud de contacto",
                                message: "Por el momento contamos con problemas con nuestros servidores, por favor espere unos momentos y vuelva a intentarlo más tarde."
                            )
                        }
                        self.showAlert(
                            title: "Invitacion enviada",
                            message: "Se envio una solicitud de contacto a la cuenta de \(emailRequest)"
                        )
                    }
                } else {
                    print("El archivo del usuario \(emailRequest) no existe dentro de la coleccion \(collection)")
                    self.showAlert(
                        title: "Usuario no encontrado",
                        message: "Es posible que el usuario con el email proporcionado se encuentre mal escrito o no este registrado, por favor verifique y vuelva a intentarlo."
                    )
                }
            }
        }
        else {
            self.showAlert(
                title: "Error de servicio - Conexión fallida",
                message: "Se detecto un problema con su cuenta, por favor cierre sesión y reinicie la app."
            )
        }
        self.emailTextField.resignFirstResponder()
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}

extension AddTabView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
