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
    func signUp(user: User, additionalInfo: UserAdditionalInfo) {
        fireBaseManager?.signUp(user: user, additionalInfo: additionalInfo) { [weak self] result in
            switch result {
            case .success(_):
                self?.vcDelegate?.getResult()
            case .failure(let failure):
                self?.vcDelegate?.getError(error: failure)
            }
        }
    }
}
