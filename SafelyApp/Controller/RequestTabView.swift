// ==================== Dependencies ====================
import UIKit

class RequestTabView: UIView {
    
    // ==================== Elements ====================
    @IBOutlet var requestTableView: UITableView!
    
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
        let xibView = Bundle.main.loadNibNamed("RequestTabView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "RequestListCell", bundle: nil)
        requestTableView.register(nibName, forCellReuseIdentifier: "requestCell")
        requestTableView.reloadData()
    }
    
}

// ==================== Extensions ====================
extension RequestTabView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestModel.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as? RequestListCell else {
            return UITableViewCell()
        }
        let request = RequestModel.getList()[indexPath.row]
        cell.setData(request)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let add = UIContextualAction(style: .normal, title: "Agregar") { _, _, _ in
            tableView.beginUpdates()
            RequestModel.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        add.backgroundColor = UIColor(named: "Success")
        let delete = UIContextualAction(style: .normal, title: "Eliminar") { _, _, _ in
            tableView.beginUpdates()
            RequestModel.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        delete.backgroundColor = UIColor(named: "Error")
        let swipe = UISwipeActionsConfiguration(actions: [delete, add])
        return swipe
    }
}
