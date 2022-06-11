class BaseCoordinator : Coordinator {
//array which where sve all childCoordinators
    var childCoordinator: [Coordinator] = []
    
    func start() {
        fatalError("Children coordinators should implement 'start'.")
    }
    
}
