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
        let menuButton = UIButton(type: .system)
        menuButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        let menu = UIBarButtonItem(customView: menuButton)
        menuButton.tintColor = .black
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menu.image = UIImage(named: "menu")
        menu.style = .done
        navigationItem.leftBarButtonItem = menu
    }
    
    @objc
    private func tap() {
        present(menu!, animated: true, completion: nil)
    }
}
