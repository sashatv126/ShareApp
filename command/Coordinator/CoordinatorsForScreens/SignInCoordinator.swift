import UIKit
import RxSwift

class SignInCoordinator : BaseCoordinator {

    private let navigationController : UINavigationController?
    
    private let bag = DisposeBag()
    
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        //set viewModelBuilder for first view
        let view = SignInViewController()
        
        view.viewModelBuilder = {
            ViewModel(input: $0, router: self, service: FirebaseManager())
        }
        FirebaseManager.vc = view
        navigationController?.pushViewController(view, animated: true)
    }
}

extension SignInCoordinator : Routable {
    
    func pushToSignUp() {
        let coordinator = SignUpCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        
        coordinator.start()
    }
    
    func pushToMain() {
        let coordinator = MainViewCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        
        coordinator.start()
    }
    
    func aletToError(error : Error?) {
        guard let vc = navigationController?.viewControllers.last else {
            return
        }
        guard let error = error else {
            vc.aleartController(title: "Warning", message: "Fill all fields", action: "OK")
            return
        }
        vc.aleartController(title: "Warning", message: error.localizedDescription, action: "OK")
    }
}
