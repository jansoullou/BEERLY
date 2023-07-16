//
//  SignUpProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 14/7/23.
//

import Foundation

protocol SignUpServiceProtocol: AnyObject {
    func signUp(user: User, completion: @escaping(Bool) -> Void)
}

protocol SignUpVCDelegate: AnyObject {
    func signUp(isRegistered: Bool)
}

protocol SignUpPresentorDelegate: AnyObject {
    func signUp(user: User)
}

