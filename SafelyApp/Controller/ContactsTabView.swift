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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactModel.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as! ContactListCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactListCell else {
            return UITableViewCell()
        }
        let contact = ContactModel.getList()[indexPath.row]
        cell.setData(contact)
        return cell
    }
}
