import RxSwift
import RxCocoa

struct SignUpInput {
    let email : Observable<String>
    let password : Observable<String>
    let repeatPassword : Observable<String>
    let buttonRegisterTapped : Observable<Void>
}

struct SignUpOutput {
    let register : Driver<Void>
    let message : Driver<String>
    let enable : Driver<Bool>
}

protocol SignUpViewModelProtocol {
    
    typealias ViewModelBuilder = (SignUpInput) -> SignUpViewModelProtocol
    
    var input : SignUpInput { get set }
    
    func transform(_ input : SignUpInput) -> SignUpOutput
}

