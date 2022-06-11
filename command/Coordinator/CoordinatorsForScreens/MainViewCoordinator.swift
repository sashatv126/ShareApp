import UIKit

class MainViewCoordinator : BaseCoordinator {
    
    private let navigationController : UINavigationController?
    
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        //set viewModelBuilder for first view
        let view = MainViewController()
        
        navigationController?.pushViewController(view, animated: true)
    }
}
