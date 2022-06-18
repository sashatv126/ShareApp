import UIKit
import SideMenu

class CustomTabBar : UITabBarController {
    
    private var menu : SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuViewController())
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.leftSide = true
        set()
    }
}

private extension CustomTabBar {
    func set() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "menu", style: .done, target: self, action: #selector(tap))
        
        
    }
    
    @objc
    private func tap() {
        present(menu!, animated: true, completion: nil)
    }
    
    
}
