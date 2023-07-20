//
//  SignInViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 15/7/23.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    var presentor: SignInPresentorDelegate?
    
    private var isPasswordHidden = true
    
    private lazy var signInLabel: UILabel = {
        var label = UILabel()
        label.text = "Sign in to Continue"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        label.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        label.layer.shadowOpacity = 0.2
        return label
    }()

    private lazy var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Email"
        textField.textColor = .gray
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textColor = .gray
        return textField
    }()

    private lazy var signInButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = UIColor(
                                 red: 0.88,
                                 green: 0.868,
                                 blue: 0.962,
                                 alpha: 0.7)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(authorization), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorMessage: UILabel = {
        var label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var showPassword: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
        
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        view.backgroundColor = UIColor(
                               red: 235/265,
                               green: 235/265,
                               blue: 235/265,
                               alpha: 1)
    }
    
    private func setUpSubviews() {
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(showPassword)
        view.addSubview(signInButton)
        view.addSubview(errorMessage)
    }
    
    private func setUpConstraints() {
        signInLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(200)
            maker.left.equalToSuperview().offset(40)
            maker.width.equalTo(250)
            maker.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { maker in
            maker.top.equalTo(signInLabel.snp.bottom).offset(70)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { maker in
            maker.top.equalTo(emailTextField.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        showPassword.snp.makeConstraints { maker in
            maker.centerY.equalTo(passwordTextField)
            maker.right.equalTo(passwordTextField).offset(-40)
            maker.width.equalTo(40)
            maker.height.equalTo(20)
        }
        
        signInButton.snp.makeConstraints { maker in
            maker.top.equalTo(passwordTextField.snp.bottom).offset(40)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        errorMessage.snp.makeConstraints { maker in
            maker.top.equalTo(signInButton).offset(80)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
        }
    }
    
    private func wrongData() {
        emailTextField.textColor = .red
        passwordTextField.textColor = .red
        emailTextField.placeholder = "Invalid format"
        passwordTextField.placeholder = "Invalid format"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.emailTextField.textColor = .gray
            self?.passwordTextField.textColor = .gray
            self?.emailTextField.placeholder = "Email"
            self?.passwordTextField.placeholder = "Password"
        }
    }
    
    @objc
    private func authorization() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email.count != 0,
              password.count != 0
        else {
            return
        }
        presentor?.signIn(email: email, password: password)
    }
    
    @objc
    private func showHidePassword() {
        if isPasswordHidden {
            passwordTextField.isSecureTextEntry = false
            showPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            isPasswordHidden = false
        } else {
            passwordTextField.isSecureTextEntry = true
            showPassword.setImage(UIImage(systemName: "eye"), for: .normal)
            isPasswordHidden = true
        }
    }
}

extension SignInViewController: SignInVCDelegate {
    func getResult() {
        errorMessage.text = ""
        let mainVC = CustomTabBarController()
        mainVC.modalPresentationStyle = .overFullScreen
        present(mainVC, animated: true)
    }
    
    func getError(error: Error) {
        wrongData()
        errorMessage.text = String(error.localizedDescription)
    }
}
