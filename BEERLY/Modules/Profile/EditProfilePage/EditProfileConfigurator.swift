//
//  EditProfileConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 13/7/23.
//

import UIKit

class EditProfilePageConfigurator {
    static func build(name: String, adress: String, usersImage: UIImage) -> UIViewController {
        let vc = EditProfileViewController(name: name, adress: adress, usersImage: usersImage)
        let presenter = EditProfilePresentor()
        let service = FirebaseService.shared
        
        vc.editProfilePresentorDelegate = presenter
        
        presenter.editProfileService = service
                
        return vc
    }
}
