import Firebase
import FirebaseDatabase

protocol FirebaseService {
    
    var success : Bool { get set }
    
    func auth(email : String, password : String, _ completion : @escaping (Error?) -> ())
    func register(email : String, password : String)
}

class FirebaseManager : FirebaseService {
    
    var success = false
    
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
}
