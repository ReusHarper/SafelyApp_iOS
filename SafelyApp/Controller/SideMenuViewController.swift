// ==================== Dependencies ====================
import UIKit

struct optionMenu {
    var title: String
    var image: String
}

class SideMenuViewController: UIViewController {
    
    // ==================== General ====================
    private var options = ["Inicio", "Perfil", "Cerrar sesión"]
    private var images = ["home", "user", "logout"]
    
    // ==================== Elements ====================
    @IBOutlet var optionsMenuTableView: UITableView!
    @IBOutlet var viewMain: UIView!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor(named: "GradientPurpleColor")
        self.viewMain.backgroundColor = UIColor(cgColor: borderColor!.cgColor)
        configureTableView()
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "SideMenuListCell", bundle: nil)
        optionsMenuTableView.register(nibName, forCellReuseIdentifier: "menuCell")
        optionsMenuTableView.reloadData()
    }
}

// ==================== Extensions ====================
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? SideMenuListCell else {
            return UITableViewCell()
        }
        let option = optionMenu(title: options[indexPath.row], image: images[indexPath.row])
        cell.setData(options: option)
        return cell
    }
}
