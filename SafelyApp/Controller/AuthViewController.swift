// Librarys and Packages
import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseAuth

class AuthViewController: ViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var loginButton: GradientButtonUI!
    @IBOutlet var signUpButton: UIButton!
    
    private var alerts = Alerts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Autenticación"
        // Agregamos un evento para analizar cada que un usuario ingresa a la app
        Analytics.logEvent("InitScreen", parameters: ["message":"Integración de Firebase completa"])
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        // Recolectamos los datos ingresados y se los pasamos a Firebase para que cree al usuario
        if let email = emailTextField.text, let password = passTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                // Si los datos ingresados son distintos de nulo y no cuentan con errores se procede a crear la cuenta del usuario
                
                print(password)
                print("correo: " + email)
                
                if error == nil {
                    // Se procede a navegar al HomeViewController para que se muestren los datos del usuario
                    //self.alert(title: "Alerta", message: "Ingresa aqui")
                    
                    self.navigationController?.pushViewController(
                        HomeViewController(email: email, provider: .basic),
                        animated: true
                    )
                     
                } else {
                    //self.alerts.message(title: "Error", message: "Se ha producido un error al intentar registrar al usuario")
                    self.alert(title: "Error", message: "Se ha producido un error al intentar registrar al usuario")
                }
                
            }
        }
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
