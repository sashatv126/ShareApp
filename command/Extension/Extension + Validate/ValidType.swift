import Foundation

extension String {
    enum ValidTypes {
        case email
        case password
        case name
    }
    
    enum Regex : String {
        case name = "[a-zA-Z]{3,}"
        case email = "[a-zA-Z0-9]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
        case password = "[a-zA-Z0-9]{6,12}"
    }
}

extension String {
    
    func isValid(validType : ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .password: regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format,regex).evaluate(with: self)
    }
}
