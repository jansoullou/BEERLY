//
//  ProfileProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

protocol ProfileServiceProtocol: AnyObject {
    func logOut(completion: @escaping (Bool) -> Void)
}

protocol ProfileVCDelegate: AnyObject {
    func logOut(result: Bool)
}

protocol ProfilePresentorDelegate: AnyObject {
    func logOut()
}
