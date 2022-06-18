import UIKit

protocol TabCoordinatorProtocol : Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabBarController = CustomTabBar()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        
        let pages: [TabBarPage] = [.go, .steady, .ready]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.ready.pageOrderNumber()
        navigationController.isNavigationBarHidden = false
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(), image: UIImage(named: page.pageImage() ?? "")?.withRenderingMode(.alwaysOriginal), tag: page.pageOrderNumber())
        
        switch page {
        case .ready:
            let vc1 = MainViewController()
            
            navController.pushViewController(vc1, animated: true)
        case .steady:
            let vc2 = MainViewController()
            
            navController.pushViewController(vc2, animated: true)
        case .go:
            let vc3 = MenuViewController()
            
            navController.pushViewController(vc3, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}
