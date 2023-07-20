//
//  FirebaseService.swift
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
    private init() { }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    private func fetchUsersAddInfo(uid: String, completion: @escaping (Result<UserAdditionalInfo, Error>) -> Void) {
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
    
    private func fetchBeerListDoc(uid: String, completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void)  {
        let collectionRef = db.collection("usersBeers").document(uid).collection("beerList")
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(documents))
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

extension FirebaseService: FirebaseServiceProtocol{
    func postBeerData(uid: String, beer: BeerElement, completion: @escaping (Result<Bool, Error>) -> Void) {
        let collectionRef = db.collection("usersBeers").document(uid).collection("beerList")
        fetchBeerListDoc(uid: uid) { result in
            switch result {
            case .success(let success):
                let beerData = [
                    "id": beer.id ?? 0,
                    "name": beer.name ?? "",
                    "description": beer.description ?? "",
                    "tagline": beer.tagline ?? "",
                    "image_url": beer.imageURL ?? "https://images.punkapi.com/v2/keg.png",
                    "brewers_tips": beer.brewersTips ?? "",
                    "contributed_by": beer.contributedBy ?? ""
                ] as [String : Any]
                
                let documentRef = collectionRef.document("\(success.count + 1)")
                documentRef.setData(beerData as [String : Any]) { error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    completion(.success(true))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

extension FirebaseService: CartServiceProtocol {
    func deleteAll(uid: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let collectionRef = db.collection("usersBeers").document(uid).collection("beerList")
        fetchBeerListDoc(uid: uid) { result in
            switch result {
            case .success(let success):
                let count = success.count
                
                for doc in 1...count {
                    let docRef = collectionRef.document("\(doc)")
                    docRef.delete() { error in
                        if let error = error {
                            completion(.failure(error))
                        }
                    }
                }
                completion(.success(true))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchBeersData(uid: String, completion: @escaping (Result<[BeerElement], Error>) -> Void) {
        let collectionRef = db.collection("usersBeers").document(uid).collection("beerList")
        
        fetchBeerListDoc(uid: uid) { result in
            switch result {
            case .success(let success):
                var beers = [BeerElement]()
                for document in success {
                    let data = document.data()
                    let id = data["id"] as? Int
                    let name = data["name"] as? String
                    let description = data["description"] as? String
                    let tagline = data["tagline"] as? String
                    let imageURL = data["image_url"] as? String
                    let brewersTips = data["brewers_tips"] as? String
                    let contributedBy = data["contributed_by"] as? String
                    let beer = BeerElement(id: id, name: name, description: description, tagline: tagline, imageURL: imageURL, brewersTips: brewersTips, contributedBy: contributedBy)
                    beers.append(beer)
                }
                completion(.success(beers))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

