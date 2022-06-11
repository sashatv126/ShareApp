import RxSwift
import RxCocoa

class SignUpViewModel : SignUpViewModelProtocol {
    
    var input: SignUpInput
    var output: SignUpOutput?
    
    private let bag = DisposeBag()
    
    private let messageSubject = BehaviorSubject<String>(value: "")
    private let registerSubject = PublishSubject<Void>()
    private let enableSubject = BehaviorSubject<Bool>(value: false)
    
    private let router : Routable
    private let service : FirebaseService
    
    init(input : SignUpInput, router : Routable, service : FirebaseService) {
        self.input = input
        self.router = router
        self.service = service
    }
    
    func transform(_ input: SignUpInput) -> SignUpOutput {
        validInputLogin(input)
        validPass(input)
        return SignUpOutput(register: register,
                            message: message,
                            enable: enableButton())
    }
}

private extension SignUpViewModel {
    var enable : Driver<Bool> {
        enableSubject.asDriver(onErrorJustReturn: false)
    }
    
    var message : Driver<String> {
        messageSubject.asDriver(onErrorJustReturn: "")
    }
    
    var register : Driver<Void> {
        registerSubject.asDriver(onErrorJustReturn: ())
    }
    
    func validInputLogin(_ input : SignUpInput) {
        Observable
            .combineLatest(input.email,input.password,input.repeatPassword)
            .map{ email, password, repeatPassword  in
                if email.isEmpty && password.isEmpty && repeatPassword.isEmpty {
                    return ""
                } else if !email.isValid(validType: .email) {
                    return "Email does not match"
                } else if !password.isValid(validType: .password) {
                    return "Password does not match"
                } else if password != repeatPassword {
                    return "Passwords doesn't match"
                } else {
                    return ""
                }
            }
            .subscribe(messageSubject)
            .disposed(by: bag)
    }
    
    func validPass(_ input : SignUpInput) {
        let result = input.buttonRegisterTapped
            .withLatestFrom(Observable.combineLatest(input.email,
                                                     input.password,
                                                     input.repeatPassword))
            .share()
        result.map({[weak self] (email, password, _) in
            guard let self = self else { return }
            self.service.register(email: email, password: password)
            self.router.pop()
        })
        .subscribe(registerSubject)
        .disposed(by: bag)
    }
    
    func enableButton() -> Driver<Bool> {
        return message.map{$0 == ""}
    }
}
