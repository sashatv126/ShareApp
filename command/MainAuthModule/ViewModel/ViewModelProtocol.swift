import RxSwift
import RxCocoa

struct SignInInput {
    let email : Observable<String>
    let password : Observable<String>
    let buttonLoginTapped : Observable<Void>
    let buttonGoogleTapped : Observable<Void>
    let buttonSignUpTapped : Observable<Void>
}

struct SignInOutput {
    let login : Driver<Void>
    let google : Driver<Void>
    let signUp : Driver<Void>
}

protocol ViewModelProtocol {
    
    typealias ViewModelBuilder = (SignInInput) -> ViewModelProtocol
    
    var input : SignInInput { get set }
    
    func transform(_ input : SignInInput) -> SignInOutput
}
