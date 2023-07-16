//
//  EnterNumViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import UIKit
import SnapKit

class EnterNumViewController: UIViewController {
    
    private lazy var registrationLabel: UILabel = {
        var label = UILabel()
        label.text = "Enter your phone number"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 27, weight: .heavy)
        label.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        label.layer.shadowOpacity = 0.2
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.textColor = .gray
        return textField
    }()
    
    private lazy var getTheCodeButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(
                                 red: 240/265,
                                 green: 240/265,
                                 blue: 240/265,
                                 alpha: 0.8)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorMessage: UILabel = {
        var label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        view.backgroundColor = UIColor(
                               red: 0.88,
                               green: 0.868,
                               blue: 0.962,
                               alpha: 0.9)
    }
    
    private func setUpSubviews() {
        view.addSubview(registrationLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(getTheCodeButton)
        view.addSubview(errorMessage)
    }
    
    private func setUpConstraints() {
        registrationLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(phoneNumberTextField.snp.top).offset(-80)
            maker.left.equalToSuperview().offset(40)
            maker.width.equalTo(250)
            maker.height.equalTo(70)
        }
        
        phoneNumberTextField.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        getTheCodeButton.snp.makeConstraints { maker in
            maker.top.equalTo(phoneNumberTextField.snp.bottom).offset(80)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        errorMessage.snp.makeConstraints { maker in
            maker.top.equalTo(getTheCodeButton).offset(80)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
        }
    }
    
    @objc
    private func goToNextPage() {
        guard let phoneNumber = phoneNumberTextField.text, phoneNumber.count != 0 else {
            wrongNum()
            return
        }
        
        let signUpVC = SignUpConfigurator.build(phoneNum: phoneNumberTextField.text!)
        signUpVC.modalPresentationStyle = .fullScreen
    
        present(signUpVC, animated: true)
    }
    
    private func wrongNum() {
        phoneNumberTextField.textColor = .red
        phoneNumberTextField.placeholder = "Invalid format"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.phoneNumberTextField.textColor = .gray
            self?.phoneNumberTextField.placeholder = "Phone Number"
        }
    }
}

