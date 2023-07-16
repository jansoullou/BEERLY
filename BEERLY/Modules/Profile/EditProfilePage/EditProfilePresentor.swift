//
//  EditProfilePresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import Foundation

class EditProfilePresentor {
    var editProfileService: EditProfileServiceProtocol?
}

extension EditProfilePresentor: EditProfilePresentorDelegate {
    func updateData(uid: String, name: String, adress: String) {
        editProfileService?.updateData(uid: uid, name: name, adress: adress)
    }
}

