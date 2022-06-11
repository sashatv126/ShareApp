import UIKit
import RxSwift
import RxCocoa

class MainView : UIView {
    
//MARK: -CreateUI
    lazy var welcomeLabel = createWelcomeLabel()
    lazy var loginLabel = createLoginLabel()
    lazy var emailLabel = createEmailLabel()
    lazy var passwordLabel = createPasswordLabel()
    lazy var registerlabel = createRegisterlabel()
    lazy var googleButton = createGoogleButton()
    lazy var signUpButton = createSignInButton()
    lazy var loginButton = createLoginButton()
    lazy var emailTextField = createEmailTextField()
    lazy var passwordTextField = createPasswordTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
