// ==================== Dependencies ====================
import UIKit
import Firebase
//import FirebaseAnalytics
import FirebaseAuth

class SignUpViewController: UIViewController {

    // ==================== General ====================
    var user : LoginUserEmail?
    var userCreated : User?
    private var alerts = Alerts()
    
    // ==================== Text fields ====================
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordRepeatTextField: UITextField!
    
    // ==================== Buttons ====================
    @IBOutlet var signUpButton: GradientButtonUI!
    @IBOutlet var logInButton: UIButton!
    
    // ==================== Propierties ====================
    private var email : String?
    private var provider : ProviderType? = .basic
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Creacion de cuenta
    @IBAction func signupButtonAction(_ sender: Any) {
        if validateFields() == true {
            signUp()
        }
    }
    
    func validateFields() -> Bool {
        let name = nameTextField.text
        let email = emailTextField.text
        let pass = passwordTextField.text
        let passRepeat = passwordRepeatTextField.text
        
        
        if name?.isEmpty == true || email?.isEmpty == true || pass?.isEmpty == true || passRepeat?.isEmpty == true {
            if name?.isEmpty == true {
                print("No name text")
            }
            
            if email?.isEmpty == true {
                print("No email text")
            }
            
            if pass?.isEmpty == true {
                print("No password text")
            }
            
            if passRepeat?.isEmpty == true {
                print("No password x2 text")
            }
            
            return false
        }
        
        return true
    }
    
    func signUp() {
        // Definicion de los datos del usuario a ingresar al sistema
        let email = emailTextField.text
        let password = passwordTextField.text
        
        user = LoginUserEmail(email: email!, pType: .basic)
        
        Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] authResult, error in
            //guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            self!.checkUserInfo()
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "ControllerMain", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "HomeID") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            vc.userReceived = user
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
