//
//  SignInProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 15/7/23.
//

import Foundation

protocol SignInServiceProtocol: AnyObject {
    func signIn(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void)
}

protocol SignInVCDelegate: AnyObject {
    func getResult()
    func getError(error: Error)
    
}

protocol SignInPresentorDelegate: AnyObject {
    func signIn(email: String, password: String)
}

