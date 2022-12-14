// ==================== Dependencies ====================
import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseAuth

class AuthViewController: UIViewController {

    // ==================== Text fields ====================
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    // ==================== Buttons ====================
    @IBOutlet var loginButton: GradientButtonUI!
    @IBOutlet var signUpButton: UIButton!
    
    // ==================== Objects ====================
    private var alerts = Alerts()
    var user : LoginUserEmail?
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Agregamos un evento para analizar cada que un usuario ingresa a la app
        Analytics.logEvent("InitScreen", parameters: ["message":"Integración de Firebase completa"])
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if validateFields() == true {
            login()
        }
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        // Cambio de vista a "Sign Up"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func validateFields() -> Bool {
        let email = emailTextField.text
        let pass = passTextField.text
        
        if email?.isEmpty == true || pass?.isEmpty == true {
            if email?.isEmpty == true {
                print("No email text")
            }
            
            if pass?.isEmpty == true {
                print("No password text")
            }
            
            return false
        }
        
        return true
    }
    
    func login() {
        // Definicion de los datos del usuario a ingresar al sistema
        let email = emailTextField.text
        let password = passTextField.text
        
        user = LoginUserEmail(email: email!, pType: .basic)
        print("email: \(String(describing: user?.email))")
        print("password: \(String(describing: password))")
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            //guard let strongSelf = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            self!.checkUserInfo()
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "home") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            vc.userReceived = user
            present(vc, animated: true, completion: nil)
        }
    }
    
}
