// ==================== Dependencies ====================
import FirebaseAuth
import FirebaseFirestore
import UIKit

class AccountViewController: UIViewController {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var alerts = Alerts()
    
    // ==================== Elements ====================
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var directionTextLabel: UILabel!
    @IBOutlet var phoneTextLabel: UILabel!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var directionTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    @IBOutlet var accountImage: UIImageView!

    // ==================== Buttons ====================
    @IBOutlet var acceptButton: GradientButtonUI!
    @IBOutlet var cancelButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
        getData(email: user?.email)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func customInit() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = borderColor?.cgColor
        
        nameTextField.delegate = self
        directionTextField.delegate = self
        phoneTextField.delegate = self
        
        phoneTextField.keyboardType = .phonePad
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction func acceptAction(_ sender: Any) {
        updateData(email: user?.email)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getData(email: String?) {
        if (email != nil) {
            let COLLECTION = "users"
            
            let NAME = "name"
            let ADDRESS = "address"
            let PHONE = "phone"
            
            database.collection(COLLECTION).document(String(email!)).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, document.exists {
                    self.nameTextField.text = document.get(NAME) as? String
                    self.directionTextField.text = document.get(ADDRESS) as? String
                    self.phoneTextField.text = document.get(PHONE) as? String
                }
            }
        }  else {
            alerts.message(
                title: "Fallo al cargar información personal",
                message: "Por el momento contamos con problemas con nuestros servidores, por favor espere unos momentos y vuelva a intentarlo más tarde."
            )
        }
    }
    
    private func updateData(email: String?) {
        if (email != nil) {
            let COLLECTION = "users"
            
            let NAME = "name"
            let ADDRESS = "address"
            let PHONE = "phone"
            
            let _NAME = self.nameTextField.text ?? ""
            let _ADDRESS = self.directionTextField.text ?? ""
            let _PHONE = self.phoneTextField.text ?? ""
            
            database.collection(COLLECTION).document(email!).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.database.collection(COLLECTION).document(email!).updateData([
                        NAME :  _NAME,
                        ADDRESS : _ADDRESS,
                        PHONE : _PHONE
                    ])
                    { err in
                        if let err = err {
                            print("Error al añadir el campo en el documento: \(err)")
                            self.showAlert(
                                title: "Error de servicio - Actualización de información de perfil",
                                message: "Por el momento contamos con problemas con nuestros servidores, por favor espere unos momentos y vuelva a intentarlo más tarde."
                            )
                        }
                        self.showAlert(
                            title: "Información actualizada",
                            message: "Los datos ingresados se actualizaron correctamente en su cuenta"
                        )
                    }
                } else {
                    self.showAlert(
                        title: "Error de servicio - Datos de cuenta no encontrados",
                        message: "Se detecto un problema con su cuenta, por favor cierre sesión y reinicie la app."
                    )
                    print("El archivo del usuario \(String(describing: email)) no existe dentro de la coleccion \(COLLECTION)")
                }
            }
        } else {
            self.showAlert(
                title: "Error de servicio - Problema con cuenta de email",
                message: "Se detecto un problema con su cuenta, por favor cierre sesión y reinicie la app."
            )
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
