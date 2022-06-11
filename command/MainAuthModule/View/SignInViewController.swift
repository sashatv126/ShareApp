import UIKit
import RxSwift
import RxCocoa

class SignInViewController : UIViewController {
    
    var viewModel : ViewModelProtocol!
    var viewModelBuilder : ViewModelProtocol.ViewModelBuilder!

    private let bag = DisposeBag()
    
    var mainView : MainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        viewModelAssembly()
        bind()
    }
}
//MARK: -setupView
private extension SignInViewController {
    //build viewmodel
    func viewModelAssembly() {
        viewModel = viewModelBuilder(
            SignInInput(email: mainView.emailTextField.rx.text.orEmpty.asObservable(),
                  password: mainView.passwordTextField.rx.text.orEmpty.asObservable(),
                  buttonLoginTapped: mainView.loginButton.rx.tap.asObservable(),
                  buttonGoogleTapped: mainView.googleButton.rx.tap.asObservable(),
                  buttonSignUpTapped: mainView.signUpButton.rx.tap.asObservable())
        )
    }
    
    func bind() {
        let output = viewModel.transform(self.viewModel.input)
        //bind login button
        output
            .login
            .drive { _ in}
    }
    
    func setView() {
        mainView = MainView()
        mainView.frame = CGRect(x: 0,
                                y: 0,
                                width: view.frame.width,
                                height: view.frame.height)
        mainView.center = view.center
        view.addSubview(mainView)
    }
}
