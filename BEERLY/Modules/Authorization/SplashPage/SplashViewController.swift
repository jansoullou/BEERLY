//
//  SplashViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 15/7/23.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    private lazy var authLabel: UILabel = {
        var label = UILabel()
        label.text = "Welcome"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        label.layer.shadowOpacity = 0.2
        return label
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
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .gray
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
        view.addSubview(authLabel)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
    }
    
    private func setUpConstraints() {
        authLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(signInButton.snp.top).offset(-50)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(200)
            maker.height.equalTo(40)
        }
        
        signInButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints { maker in
            maker.top.equalTo(signInButton.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(60)
        }
    }
    
    @objc
    private func signUpTapped() {
        let registrationViewController = EnterNumViewController()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    @objc
    private func signInTapped() {
        let authorizationViewController = SignInConfigurator.build()
        navigationController?.pushViewController(authorizationViewController, animated: true)
    }
}
