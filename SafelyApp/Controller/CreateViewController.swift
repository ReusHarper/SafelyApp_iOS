// ==================== Dependencies ====================
import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseAuth

class CreateViewController: UIViewController {

    // ==================== Labels ====================
    @IBOutlet var emailTextLabel: UILabel!
    @IBOutlet var providerTextLabel: UILabel!
    
    // ==================== Buttons ====================
    @IBOutlet var closeSessionButton: GradientButtonUI!
    
    // ==================== Propierties ====================
    private var email : String?
    private var provider : ProviderType?
    
    // ==================== Objects ====================
    var userReceived : LoginUserEmail?
    var user : User?
    private var alerts = Alerts()
    
    // ==================== Methods ====================
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
    @IBAction func closeSession(_ sender: Any) {
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
