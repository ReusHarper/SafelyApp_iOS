// ==================== Dependencies ====================
import UIKit
//import Firebase
import FirebaseAnalytics
import FirebaseAuth

enum ProviderType: String {
    case basic
}

class HomeViewController: UIViewController {
    
    // ==================== Labels ====================
    @IBOutlet var emailTextLabel: UILabel!
    @IBOutlet var providerTextLabel: UILabel!
    
    // ==================== Objects ====================
    private var alerts = Alerts()
    var userReceived : LoginUserEmail?
    
    // ==================== Properties ====================
    private var email: String?
    private var provider: ProviderType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Establecimiento de las propiedades
        email = userReceived?.email
        provider = userReceived?.pType
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Establecimiento de las etiquetas en la vista
        emailTextLabel.text = email
        providerTextLabel.text = provider?.rawValue
    }
    
    /*
    // La forma en como se deba cerrar sesion dependera del tipo de logeo implementado
    // (para este caso la unica forma sera la basica empleando un email)
    @IBAction func closeSessionButtonnAction(_ sender: Any) {
        switch provider {
        case .basic:
            do {
                try Auth.auth().signOut()
                // Si se empleara un navigationControoller simplemennte se debe sacar del stack de vistas
                //navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
            } catch {
                alerts.message(title: "Error", message: "No fue posible cerrar sesión")
            }
        case .none:
            print("Error: No se logro encontrar el tipo de proveedor de correo.")
        }
    }
    */
    
}
