//
//  FirebaseAuthService.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    
    static let shared = FirebaseService()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    private init() { }
    
    func fetchUsersAddInfo(uid: String, completion: @escaping (Result<UserAdditionalInfo, Error>) -> Void) {
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let name = data["name"] as? String ?? ""
                    let adress = data["address"] as? String ?? ""
                    let phoneNum = data["phone"] as? String ?? ""
                    let photo = data["photo"] as? Data ?? nil
                    let userInfo = UserAdditionalInfo(name: name, address: adress, phoneNum: phoneNum, image: photo ?? Data())
                    completion(.success(userInfo))
                }
            }
        }
    }
}

extension FirebaseService: SignUpServiceProtocol {
    func signUp(user: User, additionalInfo: UserAdditionalInfo, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard let result = result, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
            
            let userData = [
                "name": additionalInfo.name,
                "address": additionalInfo.address,
                "phone": additionalInfo.phoneNum,
                "photo": nil
            ]
            self?.db.collection("users").document(result.user.uid).setData(userData as [String : Any]) { error in
                if let error = error {
                    completion(.failure(error))
                }
            }
            
            self?.appDelegate.currentUser = User(email: result.user.email ?? "", password: "error", uid: result.user.uid)
            self?.fetchUsersAddInfo(uid: result.user.uid) { result in
                switch result {
                case .success(let success):
                    self?.appDelegate.userAddInfo = success
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension FirebaseService: SignInServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let result = result, error == nil else {
                completion(.failure(error!))
                return
            }
            self?.appDelegate.currentUser = User(email: result.user.email!, password: "error", uid: result.user.uid)
            completion(.success(true))
            
            self?.fetchUsersAddInfo(uid: result.user.uid) { result in
                switch result {
                case .success(let success):
                    self?.appDelegate.userAddInfo = success
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension FirebaseService: ProfileServiceProtocol {
    func getUsersData(uid: String, completion: @escaping (Result<UserAdditionalInfo, Error>) -> Void) {
        fetchUsersAddInfo(uid: uid, completion: completion)
    }
    
    func logOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension FirebaseService: EditProfileServiceProtocol {
    func updateDataWithoutPhoto(uid: String, name: String, adress: String) {
        let userData = [
            "name": name,
            "address": adress
        ]
        let documentRef = db.collection("users").document(uid)
        documentRef.updateData(userData)
        
        self.fetchUsersAddInfo(uid: uid) { [weak self] result in
            switch result {
            case .success(let success):
                self?.appDelegate.userAddInfo = success
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateData(uid: String, name: String, adress: String, photo: UIImage) {
        guard let imageData = photo.jpegData(compressionQuality: 0.8) else { return }
            
        let userData = [
            "name": name,
            "address": adress,
            "photo": imageData
        ] as [String : Any]
        
        let documentRef = db.collection("users").document(uid)
        documentRef.updateData(userData)
        
        self.fetchUsersAddInfo(uid: uid) { [weak self] result in
            switch result {
            case .success(let success):
                self?.appDelegate.userAddInfo = success
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
