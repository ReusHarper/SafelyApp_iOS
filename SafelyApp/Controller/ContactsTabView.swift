// ==================== Dependencies ====================
import FirebaseAuth
import FirebaseFirestore
import UIKit

class ContactsTabView: UIView {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private var emails : [String]? = []
    private var contacts : [ContactModel]?
    private let user = Auth.auth().currentUser
 
    // ==================== Elements ====================
    @IBOutlet var contactsTableView: UITableView!
    @IBOutlet var messageWithoutContactTextLabel: UILabel!
    
    // ==================== Methods ====================
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        configureTableView()
        getEmails()
    }
    
    private func viewInit() {
        let xibView = Bundle.main.loadNibNamed("ContactsTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "ContactListCell", bundle: nil)
        contactsTableView.register(nibName, forCellReuseIdentifier: "contactCell")
        contactsTableView.reloadData()
    }
    
    private func getEmails() {
        if let email = user?.email {
            database.collection("contact").document(String(email)).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, document.exists {
                    let data = document.data()
                    self.emails = data!.compactMap { ($0.value as! String) }
                    //print("Correos obtenidos: \(String(describing: self.emails))")
                    self.getDataContacts(emails: self.emails!)
                } else {
                    self.emails = []
                }
            }
        }
    }
    
    private func getDataContacts(emails: [String]) {
        if (!emails.isEmpty) {
            messageWithoutContactTextLabel.isHidden = true
            emails.forEach { email in
                getDataWithEmail(email: email)
            }
        } else{
            print("Lista de emails vacia")
            messageWithoutContactTextLabel.isHidden = false
        }
    }
    
    private func getDataWithEmail(email: String) {
        if let email = user?.email {
            database.collection("users").document(String(email)).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, document.exists {
                    let name = document.get("name") as! String
                    print("Name: \(name) - Email \(email)")
                } 
            }
        }
    }
}

// ==================== Extensions ====================
extension ContactsTabView : UITableViewDataSource, UITableViewDelegate {
    
    //weak var tableView: ContactsTabView?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactModel.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactListCell else {
            return UITableViewCell()
        }
        let contact = ContactModel.getList()[indexPath.row]
        cell.setData(contact, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            tableView.beginUpdates()
            ContactModel.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        delete.backgroundColor = UIColor(named: "Error")
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
