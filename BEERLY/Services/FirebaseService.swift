//
//  FirebaseAuthService.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseService {
    
    static let shared = FirebaseService()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private init() { }
    
    private let authManager = Auth.auth()
    private var verificationId: String?
}

extension FirebaseService: EnterNumServiceProtocol {
    func startAuth(phoneNum: String, completion: @escaping(Result<Bool, Error>)-> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNum, uiDelegate: nil) { [weak self] verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(.failure(error!))
                return
            }
            self?.verificationId = verificationID
            completion(.success(true))
        }
    }
}

extension FirebaseService: VerifyNumServiceProtocol {
    func verifyCode(code: String, completion: @escaping(Result<Bool, Error>)-> Void) {
        guard let verificationId = verificationId else {
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        
        authManager.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
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
            
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                self?.appDelegate.currentUser = User(email: currentUser.email ?? "", password: "error", uid: currentUser.uid)
            }
            
            print(self?.appDelegate.currentUser)
            
            let userData = [
                "name": additionalInfo.name,
                "address": additionalInfo.address,
                "phone": additionalInfo.phoneNum
            ]
            
            let ref = Database.database().reference().child("users").child(result.user.uid)
            ref.setValue(userData) { error, result in
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    completion(.success(true))
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
            print("num: \(result.user.phoneNumber)")
            print("PROVIDER: \(result.credential?.provider)")
            self?.appDelegate.currentUser = User(email: result.user.email!, password: "error", uid: result.user.uid)
            completion(.success(true))
        }
    }
}

extension FirebaseService: ProfileServiceProtocol {
    func logOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUserData(uid: String, completion: @escaping (Result<UserAdditionalInfo, Error>) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let userDataDict = snapshot.value as? [String: Any],
               let name = userDataDict["name"] as? String,
               let address = userDataDict["address"] as? String,
               let phoneNum = userDataDict["phone"] as? String
            {
                let userData = UserAdditionalInfo(name: name, address: address, phoneNum: phoneNum)
                completion(.success(userData))
            }
        }) { error in
            completion(.failure(error))
            print(error.localizedDescription)
        }
    }
}

extension FirebaseService: EditProfileServiceProtocol {
    func updateData(uid: String, name: String, adress: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userData = [
            "name": name,
            "address": adress
        ]
        
        let ref = Database.database().reference().child("users").child(currentUser.uid)
        ref.updateChildValues(userData) { error, _ in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
