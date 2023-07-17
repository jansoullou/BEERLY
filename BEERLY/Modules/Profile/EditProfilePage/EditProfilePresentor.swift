//
//  EditProfilePresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import UIKit

class EditProfilePresentor {
    var editProfileService: EditProfileServiceProtocol?
}

extension EditProfilePresentor: EditProfilePresentorDelegate {
    func updateDataWithoutPhoto(uid: String, name: String, adress: String) {
        editProfileService?.updateDataWithoutPhoto(uid: uid, name: name, adress: adress)
    }
    
    func updateData(uid: String, name: String, adress: String, photo: UIImage) {
        editProfileService?.updateData(uid: uid, name: name, adress: adress, photo: photo)
    }
}

