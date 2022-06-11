protocol Coordinator : AnyObject {
    
    var childCoordinator : [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
//Add new coordinator to array
    func add(coordinator : Coordinator) -> Void {
        childCoordinator.append(coordinator)
    }
//remove coordinator from array
    func remove(coordinator : Coordinator) -> Void {
        childCoordinator = childCoordinator.filter({ $0 !== coordinator })
    }
}
