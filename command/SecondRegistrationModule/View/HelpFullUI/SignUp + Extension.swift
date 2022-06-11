import UIKit

extension SignUpView {
    
    func createPasswordTextField() -> UITextField {
        let passwordTextField = OneLineTextField(font: .systemFont(ofSize: 20))
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }
    
    func createEmailTextField() -> UITextField {
        let passwordTextField = OneLineTextField(font: .systemFont(ofSize: 20))
        return passwordTextField
    }
    
    func createRepeatPasswordTextField() -> UITextField {
        let passwordTextField = OneLineTextField(font: .systemFont(ofSize: 20))
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }
    
    func createRegisterButton() -> UIButton {
        let loginButton = UIButton(title: "Register?",
                                   titleColor: .white,
                                   backGroundColor: .systemMint,
                                   isShadow: true)
        loginButton.isEnabled = false
        return loginButton
    }
    
    func createWelcomeLabel() -> UILabel {
        let welcomeLabel = UILabel(text: "SignUp",
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
    
    func createRepeatPasswordLabel() -> UILabel {
        let passwordLabel = UILabel(text: "Repeat password",
                                    font: .systemFont(ofSize: 25))
        passwordLabel.textAlignment = .left
        return passwordLabel
    }
    
    func createValidLabel() -> UILabel {
        let passwordLabel = UILabel(text: "",
                                    font: .systemFont(ofSize: 14))
        passwordLabel.textColor = .systemRed
        passwordLabel.textAlignment = .left
        return passwordLabel
    }
}

extension SignUpView {
    func setupConstraints() {
        
        self.backgroundColor = .white
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                         axis: .vertical,
                                         spacing: 10)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField],
                                            axis: .vertical,
                                            spacing: 10)
        let repeatPasswordStackView = UIStackView(arrangedSubviews: [repeatPasswordLabel,repeatPasswordTextField], axis: .vertical, spacing: 10)
        let stackView = UIStackView(arrangedSubviews:
                                        [ emailStackView, passwordStackView, repeatPasswordStackView],
                                    axis: .vertical,
                                    spacing: 40)
        registerButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let bottomStackView = UIStackView(arrangedSubviews:
                                            [registerButton],
                                          axis: .horizontal,
                                          spacing: 0)
        validLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(welcomeLabel)
        self.addSubview(validLabel)
        self.addSubview(stackView)
        self.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 150),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            validLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: 40),
            validLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 90),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 55),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40)
        ])
    }
}
