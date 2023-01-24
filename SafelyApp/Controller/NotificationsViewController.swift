// ==================== Dependencies ====================
import UIKit

class NotificationsViewController: UIViewController {
    
    // ==================== General ====================
    
    // ==================== Elements ====================
    @IBOutlet var notificationsTextLabel: UILabel!
    @IBOutlet var notificationsTableView: UITableView!
    
    // ==================== Buttons ====================
    @IBOutlet var returnButton: GradientButtonUI!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    @IBAction func returnAction(_ sender: Any) {
        print("Regresar a Home")
        dismiss(animated: true, completion: nil)
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "NotificationListCell", bundle: nil)
        notificationsTableView.register(nibName, forCellReuseIdentifier: "notifyCell")
        notificationsTableView.reloadData()
    }

}

// ==================== Extensions ====================
extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationsModel.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as? NotificationListCell else {
            return UITableViewCell()
        }
        let notify = NotificationsModel.getList()[indexPath.row]
        cell.setData(notify)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            tableView.beginUpdates()
            NotificationsModel.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        delete.backgroundColor = UIColor(named: "Error")
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}