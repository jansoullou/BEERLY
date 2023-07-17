//
//  ProfileProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

protocol ProfileServiceProtocol: AnyObject {
    func logOut(completion: @escaping (Bool) -> Void)
    func getUsersData(uid: String, completion: @escaping(Result<UserAdditionalInfo, Error>) -> Void)
}

protocol ProfileVCDelegate: AnyObject {
    func logOut(result: Bool)
    func getUsersData(data: UserAdditionalInfo)
    func getError(error: Error)
}

protocol ProfilePresentorDelegate: AnyObject {
    func logOut()
    func getUsersData(uid: String)
}
