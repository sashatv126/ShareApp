import Foundation
enum ErrorWithRegister : Error {
    //error with data
    case userNotFound
}

extension ErrorWithRegister : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNotFound:
            return NSLocalizedString(
                "The User not found.",
                comment: "Invalid login"
            )
        }
    }
}
