//
//  SignUpProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 14/7/23.
//

import Foundation

protocol SignUpServiceProtocol: AnyObject {
    func signUp(user: User, additionalInfo: UserAdditionalInfo, completion: @escaping(Result<Bool, Error>) -> Void)
}

protocol SignUpVCDelegate: AnyObject {
    func getResult()
    func getError(error: Error)
}

protocol SignUpPresentorDelegate: AnyObject {
    func signUp(user: User, additionalInfo: UserAdditionalInfo)
}

