import RxSwift
import RxCocoa
import RxRelay

final class ViewModel : ViewModelProtocol {
    func signResult() {
    }
    
    var input: SignInInput
    var output: SignInOutput?
    
    private let bag = DisposeBag()
    
    private let loginSubject = PublishSubject<Void>()
    private let googleSubject = PublishSubject<Void>()
    private let signUpSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error?>()
    
    private let router : Routable
    private let service : FirebaseService
    
    init(input : SignInInput, router : Routable, service : FirebaseService) {
        self.input = input
        self.router = router
        self.service = service
    }
    
    func transform(_ input: SignInInput) -> SignInOutput {
        validGoogle(input)
        signUpTap(input)
        validPass(input)
        return SignInOutput(login: login,
                      google: google,
                      signUp: signUp
        )
    }
}

extension ViewModel {
    
    func signResult(_ error : Error?) {
    }
    
    func iputIsValid(_ input : SignInInput) -> Driver<Bool> {
        //check the User struct for error and empty
        Observable
            .combineLatest(input.email,input.password)
            .map({ email, password in
                !email.isEmpty && !password.isEmpty
            }).asDriver(onErrorJustReturn: false)
    }
}

private extension ViewModel {
    
    var google : Driver<Void> {
        googleSubject.asDriver(onErrorJustReturn: ())
    }
    
    var signUp : Driver<Void> {
        signUpSubject.asDriver(onErrorJustReturn: ())
    }
        
    var login : Driver<Void> {
        loginSubject.asDriver(onErrorJustReturn: ())
    }
    
    func validPass(_ input : SignInInput) {
        let result = input.buttonLoginTapped
            .withLatestFrom(Observable.combineLatest(input.email,input.password))
            .share()
        result.map{[weak self] email, password in
            if !email.isEmpty && !password.isEmpty {
                self?.service.auth(email: email, password: password, { error in
                    if error != nil {
                        self?.router.aletToError(error: error)
                    } else {
                        self?.router.pushToMain()
                    }
                })
            } else {
                self?.router.aletToError(error: nil)
            }
        }
            .subscribe(loginSubject)
            .disposed(by: bag)
    }
    
    func validGoogle(_ input : SignInInput) {
        let result = input.buttonGoogleTapped
            .share()
        result.map{_ in
            self.service.loginWithGoogle { error in
                if error == nil {
                    self.router.pushToMain()
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
            .subscribe(googleSubject)
            .disposed(by: bag)
    }
    
    func signUpTap(_ input : SignInInput) {
        let result = input.buttonSignUpTapped
            .share()
        result.map{[weak self] _ in
            self?.router.pushToSignUp()
        }
            .subscribe(signUpSubject)
            .disposed(by: bag)
    }
}
