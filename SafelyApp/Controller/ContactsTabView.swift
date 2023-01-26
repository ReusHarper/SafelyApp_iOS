// ==================== Dependencies ====================
import FirebaseAuth
import FirebaseFirestore
import UIKit

class ContactsTabView: UIView {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private var emails : [String]? = []
    private var contacts : [ContactModel] = []
    private let user = Auth.auth().currentUser
 
    // ==================== Elements ====================
    @IBOutlet var contactsTableView: UITableView!
    @IBOutlet var messageWithoutContactTextLabel: UILabel!
    
    // ==================== Methods ====================
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
        configureTableView()
        getEmails()
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
                print("Email de contacto: \(email)")
                getDataWithEmail(email: email)
            }
        } else{
            print("Lista de emails vacia")
            messageWithoutContactTextLabel.isHidden = false
        }
    }
    
    private func getDataWithEmail(email: String) {
        database.collection("users").document(String(email)).getDocument {
            (documentSnapshot, error) in
            if let document = documentSnapshot, document.exists {
                let name = document.get("name") as! String
                print("Name: \(name) - Email \(email)")
                self.contacts.append(ContactModel(username: name, email: email))
                self.contactsTableView.reloadData()
            }
        }
    }
    
    private func deleteContact(emailOwner: String, emailContact: String, position: Int) {
        let _emailContact = setEmailWithCorrectFormat(email: emailContact)
        print("entra aqui con el email \(String(describing: _emailContact))")
        contacts.remove(at: position)
        database.collection("contact").document(String(emailOwner)).updateData(["email_\(_emailContact)": FieldValue.delete()]) { err in
            if let err = err {
                print("Error al intentar eliminar el registro: \(err)")
            } else {
                print("El usuario \(emailContact) ha sido eliminado con exito")
            }
        }
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
    
}

// ==================== Extensions ====================
extension ContactsTabView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactListCell else {
            return UITableViewCell()
        }
        let contact = self.contacts[indexPath.row]
        cell.setData(contact, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            tableView.beginUpdates()
            guard let email = self.user?.email else {
                tableView.endUpdates()
                return
            }
            self.deleteContact(emailOwner: email, emailContact: self.contacts[indexPath.row].email, position: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        delete.backgroundColor = UIColor(named: "Error")
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
