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
    
    private let mainColor = UIColor(named: "GradientPurpleColor")
    private let secondColor = UIColor(named: "GradientVioletColor")
    private let tertiaryColor = UIColor(named: "TertiaryColor")
    
    // ==================== Elements ====================
    @IBOutlet var optionsMenuTableView: UITableView!
    @IBOutlet var viewMain: UIView!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTableView()
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "SideMenuListCell", bundle: nil)
        optionsMenuTableView.backgroundColor = mainColor
        optionsMenuTableView.register(nibName, forCellReuseIdentifier: "menuCell")
        optionsMenuTableView.reloadData()
    }
    
    private func changeView(option: String) {
        switch(option) {
        case "user":
            showAccount()
            print("user")
        case "logout":
            showLogin()
            print("logout")
        default:
            showHome()
            print("home")
        }
    }
    
    // MARK: Cambio de vista a inicial (Map)
    private func showHome() {
        let storyboard = UIStoryboard(name: "ControllerMain", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeID")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Cambio de vista de perfil (Account)
    private func showAccount() {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AccountID")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Cambio de vista inicial (Login)
    private func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "login")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Se selecciono la opcion: \(options[indexPath.row])")
        let selectedCell = tableView.cellForRow(at: indexPath)!
        selectedCell.backgroundColor = secondColor
        changeView(option: images[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)!
        selectedCell.backgroundColor = mainColor
    }
}
