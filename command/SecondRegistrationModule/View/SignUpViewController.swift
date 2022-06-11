import UIKit
import RxCocoa
import RxSwift

class SignUpViewController : UIViewController {
    
    var viewModel : SignUpViewModelProtocol!
    var viewModelBuilder : SignUpViewModelProtocol.ViewModelBuilder!

    private let bag = DisposeBag()
    
    private var mainView : SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        viewModelAssembly()
        bind()
    }
}

private extension SignUpViewController {
    //build viewmodel
    func viewModelAssembly() {
        viewModel = viewModelBuilder(
            SignUpInput(email: mainView.emailTextField.rx.text.orEmpty.asObservable(),
                        password: mainView.passwordTextField.rx.text.orEmpty.asObservable(),
                        repeatPassword: mainView.repeatPasswordTextField.rx.text.orEmpty.asObservable(),
                        buttonRegisterTapped: mainView.registerButton.rx.tap.asObservable())
        )
    }
    
    func bind() {
        let output =  viewModel.transform(self.viewModel.input)
        //bind login button
        output
            .message
            .drive(mainView.validLabel.rx.text)
            .disposed(by: bag)
        
        output
            .enable
            .drive(mainView.registerButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
    func setView() {
        mainView = SignUpView()
        mainView.frame = CGRect(x: 0,
                                y: 0,
                                width: view.frame.width,
                                height: view.frame.height)
        mainView.center = view.center
        view.addSubview(mainView)
    }
}
