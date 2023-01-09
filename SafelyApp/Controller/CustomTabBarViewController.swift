// ==================== Dependencies ====================
import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground(colorOne: UIColor(named: "GradientPurpleColor")!, colorTwo: UIColor(named: "GradientVioletColor")!)
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
        let gradientlayer = CAGradientLayer()
        //gradientlayer.frame = tabBar.bounds
        gradientlayer.frame = tabBarController!.tabBar.bounds
        gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientlayer.locations = [0, 1]
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
        self.tabBar.unselectedItemTintColor = UIColor(named: "BackgroundColor")
    }
    


    //let gradientView = UIView( : tabBarController.tabBar.bounds)
    //gradientView.layer.insertSublayer(gradient, at: 0)

    //tabBarController.tabBar.backgroundView = gradientView
}
