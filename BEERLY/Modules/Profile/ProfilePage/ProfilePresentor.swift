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
    func logOut() {
        service?.logOut { [weak self] result in
            self?.profileVCDelegate?.logOut(result: true)
        }
    }
}
