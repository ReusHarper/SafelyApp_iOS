// ==================== Dependencies ====================
import UIKit

class ContactsTabView: UIView {
 
    // ==================== Elements ====================
    @IBOutlet var contactsTableView: UITableView!
    
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
