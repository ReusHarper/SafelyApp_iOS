// ==================== Dependencies ====================
import SideMenu
import UIKit

class ViewController: UIViewController {
    
    private var menu: SideMenuNavigationController!

    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigation") as? SideMenuNavigationController
        //menu = SideMenuNavigationController(rootViewController: SideMenuViewController()) //MenuListController())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        present(menu!, animated: true)
    }
}






//class MenuListController: UITableViewController {
//    var items = ["Uno", "Dos"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = items[indexPath.row]
//        return cell
//    }
//}
