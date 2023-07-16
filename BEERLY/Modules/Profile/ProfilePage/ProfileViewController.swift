//
//  ProfileViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
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
        return view
    }()
    
    private lazy var profileName: UILabel = {
        var label = UILabel()
        label.text = "UsersName"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        return label
    }()
    
    private lazy var profileNum: UILabel = {
        var label = UILabel()
        label.text = "+00000000000"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Medium", size: 16)
        return label
    }()
    
    private lazy var profileAdress: UILabel = {
        var label = UILabel()
        label.text = "Tokombaeva 11/2 A, 4273"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Medium", size: 16)
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .darkGray
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
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(profileName)
        containerView.addSubview(profileNum)
        containerView.addSubview(profileAdress)
        containerView.addSubview(editProfileButton)
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
    }
    
    @objc
    func editProfile() {
        print("tapped")
    }
}

