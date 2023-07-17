//
//  EditProfileProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import UIKit

protocol EditProfileServiceProtocol: AnyObject {
    func updateData(uid: String, name: String, adress: String, photo: UIImage)
    func updateDataWithoutPhoto(uid: String, name: String, adress: String)
}

protocol EditProfilePresentorDelegate: AnyObject {
    func updateData(uid: String, name: String, adress: String, photo: UIImage)
    func updateDataWithoutPhoto(uid: String, name: String, adress: String)
}
