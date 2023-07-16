//
//  SignUpPresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 14/7/23.
//

import Foundation

class SignUpPresentor {
    var vcDelegate: SignUpVCDelegate?
    var fireBaseManager: SignUpServiceProtocol?
}

extension SignUpPresentor: SignUpPresentorDelegate {
    func signUp(user: User) {
        fireBaseManager?.signUp(user: user) { [weak self] result in
            switch result {
            case true:
                self?.vcDelegate?.signUp(isRegistered: true)
            case false:
                self?.vcDelegate?.signUp(isRegistered: false)
            }
        }
    }
}
