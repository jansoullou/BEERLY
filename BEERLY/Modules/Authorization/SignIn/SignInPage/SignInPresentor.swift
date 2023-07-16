//
//  SignInPresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 15/7/23.
//

import Foundation

class SignInPresentor {
    var vcDelegate: SignInVCDelegate?
    var fireBaseManager: SignInServiceProtocol?
}

extension SignInPresentor: SignInPresentorDelegate {
    func signIn(email: String, password: String) {
        fireBaseManager?.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.vcDelegate?.getResult()
            case .failure(let failure):
                self?.vcDelegate?.getError(error: failure)
            }
        }
    }
}
    
