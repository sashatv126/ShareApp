protocol Routable {
    
    func push(_ completion : () -> ())
    func pushToSignUp()
    func pushToMain()
    
    func aletToError(error : Error?)
    
    func pop()
}

extension Routable {
    
    func push(_ completion : () -> ()) {}
    func pushToSignUp() {}
    func pushToMain() {}
    
    func pop() {}
}
