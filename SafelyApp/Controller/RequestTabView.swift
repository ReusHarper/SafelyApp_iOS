// ==================== Dependencies ====================
import FirebaseAuth
import FirebaseFirestore
import UIKit

class RequestTabView: UIView {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private var emails : [String]? = []
    private var requests : [RequestModel] = []
    private let user = Auth.auth().currentUser
    
    // ==================== Elements ====================
    @IBOutlet var requestTableView: UITableView!
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
        let xibView = Bundle.main.loadNibNamed("RequestTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "RequestListCell", bundle: nil)
        requestTableView.register(nibName, forCellReuseIdentifier: "requestCell")
        requestTableView.reloadData()
    }
    
    private func getEmails() {
        if let email = user?.email {
            database.collection("request").document(String(email)).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, document.exists {
                    let data = document.data()
                    self.emails = data!.compactMap { ($0.value as! String) }
                    //print("Correos obtenidos: \(String(describing: self.emails))")
                    self.getDataRequests(emails: self.emails!)
                } else {
                    self.emails = []
                }
            }
        }
    }
    
    private func getDataRequests(emails: [String]) {
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
                self.requests.append(RequestModel(username: name, email: email))
                self.requestTableView.reloadData()
            }
        }
    }
    
    private func deleteRequest(emailOwner: String, emailRequest: String, position: Int) {
        let _emailRequest = setEmailWithCorrectFormat(email: emailRequest)
        print("entra aqui con el email \(String(describing: _emailRequest))")
        requests.remove(at: position)
        database.collection("request").document(String(emailOwner)).updateData(["email_\(_emailRequest)": FieldValue.delete()]) { err in
            if let err = err {
                print("Error al intentar eliminar el registro: \(err)")
            } else {
                print("El usuario \(emailRequest) ha sido eliminado con exito")
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
    
    private func acceptRequest(emailOwner: String, emailRequest: String) {
        let _emailOwner = setEmailWithCorrectFormat(email: emailOwner)
        let _emailRequest = setEmailWithCorrectFormat(email: emailRequest)
        let dataOwner: [String: String] = ["email_\(_emailRequest)": emailRequest]
        let dataRequest: [String: String] = ["email_\(_emailOwner)": emailOwner]
        
        database.collection("contact").document(emailRequest).setData(dataRequest, merge: true)
        database.collection("contact").document(emailOwner).setData(dataOwner, merge: true)
    }
}

// ==================== Extensions ====================
extension RequestTabView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return RequestModel.getList().count
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as? RequestListCell else {
            return UITableViewCell()
        }
        //let request = RequestModel.getList()[indexPath.row]
        let request = self.requests[indexPath.row]
        cell.setData(request)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let add = UIContextualAction(style: .normal, title: "Agregar") { _, _, _ in
            tableView.beginUpdates()
            
            guard let email = self.user?.email else {
                tableView.endUpdates()
                return
            }
            self.acceptRequest(emailOwner: email, emailRequest: self.requests[indexPath.row].email)
            self.deleteRequest(emailOwner: email, emailRequest: self.requests[indexPath.row].email, position: indexPath.row)
            
            //RequestModel.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        add.backgroundColor = UIColor(named: "Success")
        let delete = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            tableView.beginUpdates()
            
            guard let email = self.user?.email else {
                tableView.endUpdates()
                return
            }
            self.deleteRequest(emailOwner: email, emailRequest: self.requests[indexPath.row].email, position: indexPath.row)
            
            //RequestModel.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        delete.backgroundColor = UIColor(named: "Error")
        let swipe = UISwipeActionsConfiguration(actions: [delete, add])
        return swipe
    }
}
