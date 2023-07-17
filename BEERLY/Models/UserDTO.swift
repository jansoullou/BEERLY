//
//  UserDTO.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 14/7/23.
//

import Foundation

struct User {
    var email: String
    var password: String
    var uid: String
}

struct UserAdditionalInfo {
    var name: String
    var address: String
    var phoneNum: String
    var image: Data
}

