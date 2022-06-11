import UIKit

class SignUpCoordinator : BaseCoordinator {
    
    private let navigationController : UINavigationController?
    
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        //set viewModelBuilder for first view
        let view = SignUpViewController()
        
        view.viewModelBuilder = {
            SignUpViewModel(input: $0, router: self, service: FirebaseManager())
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
}

extension SignUpCoordinator : Routable {
    func aletToError(error: Error?) {
    }
    
    
    func pop() {
        remove(coordinator: self)
        navigationController?.popToRootViewController(animated: true)
    }
}
