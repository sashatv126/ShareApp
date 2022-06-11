import UIKit

class SignUpView : UIView {
    
    lazy var welcomeLabel = createWelcomeLabel()
    lazy var loginLabel = createLoginLabel()
    lazy var emailLabel = createEmailLabel()
    lazy var passwordLabel = createPasswordLabel()
    lazy var repeatPasswordLabel = createRepeatPasswordLabel()
    lazy var registerButton = createRegisterButton()
    lazy var emailTextField = createEmailTextField()
    lazy var passwordTextField = createPasswordTextField()
    lazy var repeatPasswordTextField = createRepeatPasswordTextField()
    lazy var validLabel = createValidLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
