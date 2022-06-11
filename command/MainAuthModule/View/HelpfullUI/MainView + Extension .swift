import UIKit
//MARK: -CreateUI
extension MainView {
    func createWelcomeLabel() -> UILabel {
        let welcomeLabel = UILabel(text: "Hello!",
                                   font: .systemFont(ofSize: 40))
        return welcomeLabel
    }
    
    func createLoginLabel() -> UILabel {
        let loginLabel = UILabel(text: "Login with",
                                 font: .systemFont(ofSize: 25))
        return loginLabel
    }
    
    func createEmailLabel() -> UILabel {
        let emailLabel = UILabel(text: "Email",
                                 font: .systemFont(ofSize: 25))
        emailLabel.textAlignment = .left
        return emailLabel
    }
    
    func createPasswordLabel() -> UILabel {
        let passwordLabel = UILabel(text: "Password",
                                    font: .systemFont(ofSize: 25))
        passwordLabel.textAlignment = .left
        return passwordLabel
    }
    
    func createRegisterlabel() -> UILabel {
        let registerlabel = UILabel(text: "Need an account?")
        return registerlabel
    }
    
    func createGoogleButton() -> UIButton {
        let googleButton = UIButton(title: "Google",
                              titleColor: .black,
                              backGroundColor: .white,
                              isShadow: true)
        googleButton.addImageButton()
        return googleButton
    }
        
    func createSignInButton() -> UIButton {
        let signUpButton = UIButton(title: "Sign up",
                                    titleColor: .systemBlue,
                                    backGroundColor: .white,
                                    isShadow: false)
        return signUpButton
    }
    
    func createLoginButton() -> UIButton {
        let loginButton = UIButton(title: "Login",
                                   titleColor: .white,
                                   backGroundColor: .systemMint,
                                   isShadow: true)
        return loginButton
    }
    
    func createEmailTextField() -> UITextField {
        let emailTextField = OneLineTextField(font: .systemFont(ofSize: 20))
        return emailTextField
    }
    
    func createPasswordTextField() -> UITextField {
        let passwordTextField = OneLineTextField(font: .systemFont(ofSize: 20))
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }
    
    func createValidLabel() -> UILabel {
        let loginLabel = UILabel(text: "Login with",
                                 font: .systemFont(ofSize: 16))
        return loginLabel
    }
}
//MARK: -SetupConstraints
extension MainView {
    func setupConstraints() {
        
        self.backgroundColor = .white
        
        let loginWithView = ButtonView(label: loginLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                         axis: .vertical,
                                         spacing: 10)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField],
                                            axis: .vertical,
                                            spacing: 10)
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews:
                                        [loginWithView, emailStackView, passwordStackView, loginButton],
                                    axis: .vertical,
                                    spacing: 40)
        
        let bottomStackView = UIStackView(arrangedSubviews:
                                            [registerlabel, signUpButton],
                                          axis: .horizontal,
                                          spacing: 120)
        bottomStackView.alignment = .firstBaseline
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(welcomeLabel)
        self.addSubview(stackView)
        self.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 150),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40)
        ])
    }
}

