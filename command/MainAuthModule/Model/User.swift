import Foundation
import RxSwift
import RxCocoa

typealias Users = [User]

struct User : Decodable {
    let email : String
    let password : String
    
    init(email : String, password : String) {
        self.email = email
        self.password = password
    }
    
}



