// ==================== Dependencies ====================
import FirebaseAuth
import FirebaseFirestore
import UIKit

class NotificationsViewController: UIViewController {
    
    // ==================== General ====================
    private let database = Firestore.firestore()
    private var notifications : [NotificationsModel] = []
    private let user = Auth.auth().currentUser
    
    // ==================== Elements ====================
    @IBOutlet var notificationsTextLabel: UILabel!
    @IBOutlet var notificationsTableView: UITableView!
    @IBOutlet var messageWithoutNotificationsTextLabel: UILabel!
    
    // ==================== Buttons ====================
    @IBOutlet var returnButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getNotifications()
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        getNotifications()
//    }
    
    @IBAction func returnAction(_ sender: Any) {
        print("Regresar a Home")
        dismiss(animated: true, completion: nil)
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "NotificationListCell", bundle: nil)
        notificationsTableView.register(nibName, forCellReuseIdentifier: "notifyCell")
        notificationsTableView.reloadData()
    }
    
    private func getNotifications() {
        if let email = user?.email {
            let COLLECTION = "notifications"
            
            database.collection(COLLECTION).document(String(email)).getDocument {
                (documentSnapshot, error) in
                if let document = documentSnapshot, document.exists {
                    let data = document.data()
                    
                    if (data != nil && data!.count > 0) {
                        self.messageWithoutNotificationsTextLabel.isHidden = true
                        for (key, value) in data! {
                            self.notifications.append(NotificationsModel(username: key, message: value))
                            print("entra en data: Key = \(key), Value = \(value)")
                        }
                        self.notificationsTableView.reloadData()
                    }
                    else {
                        print("Lista de notificaciones vacia")
                        self.messageWithoutNotificationsTextLabel.isHidden = false
                    }
                } else {
                    print("El documento \(email) no es creado")
                    self.messageWithoutNotificationsTextLabel.isHidden = false
                }
            }
        } else {
            print("Error - Fallo de cuenta de email")
            messageWithoutNotificationsTextLabel.isHidden = false
        }
    }
    
    private func deletetNotification(key: String, position: Int) {
        if let email = user?.email {
            let COLLECTION = "notifications"
            notifications.remove(at: position)
            
            database.collection(COLLECTION).document(String(email)).updateData([key: FieldValue.delete()]) { err in
                if let err = err {
                    print("Error al intentar eliminar el registro: \(err)")
                } else {
                    print("La notificacion del usuario \(key) ha sido eliminada con exito")
                }
            }
        }
    }

}

// ==================== Extensions ====================
extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (notifications.count == 0) {
            messageWithoutNotificationsTextLabel.isHidden = false
        }
        
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as? NotificationListCell else {
            return UITableViewCell()
        }
        
        let notify = self.notifications[indexPath.row]
        cell.setData(notify)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            tableView.beginUpdates()
            
            self.deletetNotification(key: self.notifications[indexPath.row].username , position: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        delete.backgroundColor = UIColor(named: "Error")
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
