// ==================== Dependencies ====================
import UIKit

class AddGroupViewController: UIViewController {
    
    // ==================== Views ====================
    @IBOutlet var contactView: ContactsTabView!
    @IBOutlet var addView: AddTabView!
    ///////////////////////////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var requestView: ContactsTabView!
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    // ==================== Buttons ====================
    @IBOutlet var contactsButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var requestButton: UIButton!
    
    // ==================== Constraints Buttons ====================
    @IBOutlet var contactConstraintButton: NSLayoutConstraint!
    @IBOutlet var addConstraintButton: NSLayoutConstraint!
    @IBOutlet var requestConstraintButton: NSLayoutConstraint!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showViews()
        showView(nameView: "contact")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touch")
    }
    
    // MARK: Visualizacion de contactos agregados
    @IBAction func contactsTabClicked(_ sender: Any) {
        showView(nameView: "contact")
    }
    
    // MARK: Visualizacion de envio de solicitud de contacto
    @IBAction func addTabClicked(_ sender: Any) {
        showView(nameView: "add")
    }
    
    // MARK: Visualizacion de peticiones de contacto
    @IBAction func requestTabClicked(_ sender: Any) {
        showView(nameView: "request")
    }
    
    private func showView(nameView: String) {
        switch nameView {
        case "contact":
            // Views
            contactView.isHidden = false
            addView.isHidden = true
            requestView.isHidden = true
            // Constraints
            contactConstraintButton.constant = 2.0
            addConstraintButton.constant = 0.0
            requestConstraintButton.constant = 0.0
        case "add":
            // Views
            contactView.isHidden = true
            addView.isHidden = false
            requestView.isHidden = true
            // Constraints
            contactConstraintButton.constant = 0.0
            addConstraintButton.constant = 2.0
            requestConstraintButton.constant = 0.0
        case "request":
            // Views
            contactView.isHidden = true
            addView.isHidden = true
            requestView.isHidden = false
            // Constraints
            contactConstraintButton.constant = 0.0
            addConstraintButton.constant = 0.0
            requestConstraintButton.constant = 2.0
        default:
            // Views
            contactView.isHidden = false
            addView.isHidden = true
            requestView.isHidden = true
            // Constraints
            contactConstraintButton.constant = 2.0
            addConstraintButton.constant = 0.0
            requestConstraintButton.constant = 0.0
        }
    }
    
    private func showViews() {
        showViewContacts()
        showViewAddContacts()
        //showViewRequest()
    }
    
    func showViewContacts() {
        let viewContacts = ContactsTabView()
        self.contactView.addSubview(viewContacts)
        viewContacts.frame = self.contactView.bounds
    }
    
    private func showViewAddContacts() {
        // Creating AddContacts view
        let viewAddContacts = AddTabView()
        self.addView.addSubview(viewAddContacts)
        viewAddContacts.frame = self.addView.bounds
        
        // Init custom elements
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        viewAddContacts.infoTextLabel.textColor = UIColor.black
        viewAddContacts.emailTextField.layer.borderWidth = 2.0
        viewAddContacts.emailTextField.layer.borderColor = borderColor?.cgColor
        viewAddContacts.emailTextField.layer.cornerRadius = 10
        viewAddContacts.emailTextField.textColor = UIColor.black
        viewAddContacts.cancelButton.layer.borderWidth = 2.0
        viewAddContacts.cancelButton.layer.borderColor = borderColor?.cgColor
    }
    
//    private func showViewRequest() {
//        let viewRequest = RequestTabView()
//        self.requestView.addSubview(viewRequest)
//        viewRequest.frame = self.requestView.bounds
//
//        // Init custom elements
//        viewRequest.configureTableView()
//    }
    
}
