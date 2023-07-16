//
//  ProfileViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var profilePresentorDelegate: ProfilePresentorDelegate?
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(
                               red: 0.9,
                               green: 0.9,
                               blue: 0.9,
                               alpha: 0.55)
        view.layer.cornerRadius = 25
        view.layer.shadowOffset = .init(width: 2, height: 6)
        view.layer.shadowOpacity = 0.4
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "person.circle")
        view.tintColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 75
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var profileName: UILabel = {
        var label = UILabel()
        label.text = appDelegate.userAddInfo?.name
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        return label
    }()
    
    private lazy var profileNum: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = appDelegate.userAddInfo?.phoneNum
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Medium", size: 16)
        return label
    }()
    
    private lazy var profileAdress: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = appDelegate.userAddInfo?.address
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Medium", size: 16)
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "editImageIcon"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var logOutButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setImage(UIImage(named: "logOutIcon"), for: .normal)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(profileName)
        containerView.addSubview(profileNum)
        containerView.addSubview(profileAdress)
        containerView.addSubview(editProfileButton)
        containerView.addSubview(logOutButton)
    }
    
    private func setUpConstraints() {
        containerView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.top.equalToSuperview().offset(70)
            maker.bottom.equalToSuperview().offset(-110)
        }
        
        profileImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(150)
        }
        
        profileName.snp.makeConstraints { maker in
            maker.top.equalTo(profileImageView.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
        }
        
        profileNum.snp.makeConstraints { maker in
            maker.top.equalTo(profileName.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
        }
        
        profileAdress.snp.makeConstraints { maker in
            maker.top.equalTo(profileNum.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
        }
        
        editProfileButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.width.height.equalTo(40)
        }
        
        logOutButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-20)
            maker.right.equalToSuperview().offset(-30)
            maker.width.equalTo(30)
            maker.height.equalTo(30)
        }
    }
    
    @objc
    private func editProfile() {
        let editProfileVC = EditProfilePageConfigurator.build(name: profileName.text!, adress: profileAdress.text!, usersImage: profileImageView.image!)
        editProfileVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc
    private func signOut() {
        profilePresentorDelegate?.logOut()
    }
}

extension ProfileViewController: ProfileVCDelegate {
    func logOut(result: Bool) {
        if result {
            let splashVC = UINavigationController(rootViewController: SplashViewController())
            splashVC.modalPresentationStyle = .overFullScreen
            present(splashVC, animated: true)
            self.appDelegate.currentUser = nil
        }
    }
    
    func getError(error: Error) {
        print(error.localizedDescription)
    }
}
