import UIKit
//Not yet end!!!
class AppMainCoordinator: BaseCoordinator {
    
    private let window : UIWindow
    
    private let navigationController : UINavigationController = {
        let navigationController = UINavigationController()
        
        return navigationController
    }()
    
    init(window : UIWindow) {
        self.window = window
    }
//create new window for start application
    override func start() {
        
        let mainCoordinator = MainViewCoordinator(navigationController: navigationController)
        self.add(coordinator: mainCoordinator)
        
        mainCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
