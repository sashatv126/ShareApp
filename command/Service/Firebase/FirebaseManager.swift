import Firebase
import FirebaseDatabase
import GoogleSignIn

protocol FirebaseService {
    
    func auth(email : String, password : String, _ completion : @escaping (Error?) -> ())
    
    func register(email : String, password : String)
    
    func logOut()
    
    func loginWithGoogle(completion : @escaping (Error?) -> ())
    
}

class FirebaseManager : FirebaseService {
    
    static var vc : UIViewController = UIViewController()
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                print("error")
            }
        }
    }
    
    func auth(email: String, password: String, _ completion : @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result , error in
            if error == nil {
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func loginWithGoogle(completion : @escaping (Error?) -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: FirebaseManager.vc) { user, error in
            
            if error != nil {
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with : credential) { result, error in
                if error != nil {
                    completion(error)
                    return
                }
                
                guard let user = result?.user else {
                    return
                }
                completion(nil)
                print(user.displayName!)
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


