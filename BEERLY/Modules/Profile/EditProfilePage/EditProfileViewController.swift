//
//  EditProfileViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//
//
import UIKit
import SnapKit

class EditProfileViewController: UIViewController {
    
    var name: String?
    var adress: String?
    var usersImage: UIImage?
    
    var editProfilePresentorDelegate: EditProfilePresentorDelegate?

    init(name: String, adress: String, usersImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
        self.adress = adress
        self.usersImage = usersImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let view = UIImagePickerController()
        view.delegate = self
        view.allowsEditing = true
        view.sourceType = .photoLibrary
        return view
    }()
    
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
        view.image = usersImage
        view.tintColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 75
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var editImage: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "editImageIcon"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        return button
    }()

    private lazy var profileNameTextField: UITextField = {
        var tf = UITextField()
        tf.text = name
        tf.font = UIFont(name: "Avenir Next Medium", size: 16)
        return tf
    }()

    private lazy var profileAdressTextField: UITextField = {
        var tf = UITextField()
        tf.text = adress
        tf.font = UIFont(name: "Avenir Next Medium", size: 16)
        return tf
    }()

    private lazy var saveInfoButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = .init(width: 5, height: 5)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 20)
        button.setTitleColor(.white, for: .normal)

        button.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)
        
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
    
    @objc
    private func saveInfo() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if profileImageView.image != UIImage(systemName: "person.circle") {
            editProfilePresentorDelegate?.updateData(uid: appDelegate.currentUser!.uid, name: profileNameTextField.text!, adress: profileAdressTextField.text!, photo: profileImageView.image!)
        } else {
            editProfilePresentorDelegate?.updateDataWithoutPhoto(uid: appDelegate.currentUser!.uid, name: profileNameTextField.text!, adress:  profileAdressTextField.text!)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func edit() {
        showImagePickerController()
    }

    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        view.backgroundColor = .white
    }

    private func setUpSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(editImage)
        containerView.addSubview(profileNameTextField)
        containerView.addSubview(profileAdressTextField)
        containerView.addSubview(saveInfoButton)
    }

    private func setUpConstraints() {
        containerView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.top.equalToSuperview().offset(100)
            maker.bottom.equalToSuperview().offset(-110)
        }

        profileImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(150)
        }

        profileNameTextField.snp.makeConstraints { maker in
            maker.top.equalTo(profileImageView.snp.bottom).offset(20)
            maker.width.equalTo(300)
            maker.height.equalTo(30)
            maker.centerX.equalToSuperview()
        }

        profileAdressTextField.snp.makeConstraints { maker in
            maker.top.equalTo(profileNameTextField.snp.bottom).offset(20)
            maker.width.equalTo(300)
            maker.height.equalTo(30)
            maker.centerX.equalToSuperview()
        }
        
        saveInfoButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-20)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-40)
            maker.height.equalTo(40)
        }
        
        editImage.snp.makeConstraints { maker in
            maker.bottom.equalTo(profileImageView).offset(10)
            maker.right.equalTo(profileImageView)
            maker.width.height.equalTo(35)
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func showImagePickerController() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            usersImage = editedImage
            profileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            usersImage = originalImage
            profileImageView.image = originalImage
        }

        dismiss(animated: true)
    }
}
