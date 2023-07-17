//
//  ProfilePresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

class ProfilePresentor {
    var profileVCDelegate: ProfileVCDelegate?
    var service: ProfileServiceProtocol?
}

extension ProfilePresentor: ProfilePresentorDelegate {
    func getUsersData(uid: String) {
        service?.getUsersData(uid: uid) { [weak self] result in
            switch result {
            case .success(let success):
                self?.profileVCDelegate?.getUsersData(data: success)
            case .failure(let failure):
                self?.profileVCDelegate?.getError(error: failure)
            }
        }
    }
    
    func logOut() {
        service?.logOut { [weak self] result in
            self?.profileVCDelegate?.logOut(result: true)
        }
    }
}
