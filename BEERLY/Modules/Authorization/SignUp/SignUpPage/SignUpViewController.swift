//
//  SignUpViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 14/7/23.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    var presentor: SignUpPresentorDelegate?
    
    private var phoneNumber: String?
    
    private var isPasswordHidden = true
    
    init(phoneNumber: String?) {
        super.init(nibName: nil, bundle: nil)
        self.phoneNumber = phoneNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var registrationLabel: UILabel = {
        var label = UILabel()
        label.text = "Create account"
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
    
    private lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Name"
        textField.textColor = .gray
        return textField
    }()
    
    private lazy var adressTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Address"
        textField.textColor = .gray
        return textField
    }()
    
    private lazy var showPassword: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = UIColor(
                                 red: 240/265,
                                 green: 240/265,
                                 blue: 240/265,
                                 alpha: 0.8)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(saveRegistrationData), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorMessage: UILabel = {
        var label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(phoneNumber)
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        view.backgroundColor = UIColor(
                               red: 0.88,
                               green: 0.868,
                               blue: 0.962,
                               alpha: 1)
    }
    
    private func setUpSubviews() {
        view.addSubview(registrationLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(showPassword)
        view.addSubview(nameTextField)
        view.addSubview(adressTextField)
        view.addSubview(signUpButton)
        view.addSubview(errorMessage)
    }
    
    private func setUpConstraints() {
        registrationLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(170)
            maker.left.equalToSuperview().offset(40)
            maker.width.equalTo(250)
            maker.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { maker in
            maker.top.equalTo(registrationLabel.snp.bottom).offset(50)
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
        
        nameTextField.snp.makeConstraints { maker in
            maker.top.equalTo(passwordTextField.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        adressTextField.snp.makeConstraints { maker in
            maker.top.equalTo(nameTextField.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints { maker in
            maker.top.equalTo(adressTextField.snp.bottom).offset(40)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        errorMessage.snp.makeConstraints { maker in
            maker.top.equalTo(signUpButton.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
        }
    }
    
    @objc
    func saveRegistrationData() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let name = nameTextField.text,
              let adress = adressTextField.text,
              email.count != 0,
              password.count != 0,
              name.count != 0,
              adress.count != 0
        else {
            wrongData()
            return
        }
        
        let user = User(email: emailTextField.text!, password: passwordTextField.text!, uid: "")
        let addInfo = UserAdditionalInfo(name: nameTextField.text!, address: adressTextField.text!, phoneNum:  phoneNumber!)
        print(user)
        presentor?.signUp(user: user, additionalInfo: addInfo)
    }
    
    private func wrongData() {
        emailTextField.textColor = .red
        nameTextField.textColor = .red
        adressTextField.textColor = .red
        passwordTextField.textColor = .red
        emailTextField.placeholder = "Invalid format"
        nameTextField.placeholder = "Invalid format"
        adressTextField.placeholder = "Invalid format"
        passwordTextField.placeholder = "Invalid format"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.emailTextField.textColor = .gray
            self?.nameTextField.textColor = .gray
            self?.adressTextField.textColor = .gray
            self?.passwordTextField.textColor = .gray
            self?.emailTextField.placeholder = "Email"
            self?.nameTextField.placeholder = "Name"
            self?.adressTextField.placeholder = "Adress"
            self?.passwordTextField.placeholder = "Password"
        }
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

extension SignUpViewController: SignUpVCDelegate {
    func getResult() {
        errorMessage.text = ""
        let mainVC = CustomTabBarController()
        print("success")
        mainVC.modalPresentationStyle = .overFullScreen
        present(mainVC, animated: true)
    }
    
    func getError(error: Error) {
        wrongData()
        print(error.localizedDescription)
        errorMessage.text = error.localizedDescription
    }
}
