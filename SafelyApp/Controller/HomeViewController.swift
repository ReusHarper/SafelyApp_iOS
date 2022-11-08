// Librarys and Packages
import UIKit
import FirebaseAuth

enum ProviderType: String {
    case basic
}

class HomeViewController: UIViewController {
    
    @IBOutlet var emailTextLabel: UILabel!
    @IBOutlet var providerTextLabel: UILabel!
    @IBOutlet var closeSessionButton: GradientButtonUI!
    
    private let email: String
    private let provider: ProviderType
    private var alerts = Alerts()
    
    init(email: String, provider: ProviderType) {
        //print("xd: " + email)
        //print(provider)
        self.email = email
        self.provider = provider
        print("self.mail: " + self.email)
        
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Inicio"
        emailTextLabel.text = email
        providerTextLabel.text = provider.rawValue
    }
    
    // La forma en como se deba cerrar sesion dependera del tipo de logeo implementado
    @IBAction func closeSessionButtonnAction(_ sender: Any) {
        switch provider {
        case .basic:
            do {
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            } catch {
                alerts.message(title: "Error", message: "No fue posible cerrar sesión")
            }
        }
    }

}
