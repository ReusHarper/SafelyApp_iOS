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
        cell.initCustomElements()
        cell.setData(request)
        return cell
    }
}
