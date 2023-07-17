//
//  ProfileConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

class ProfilePageConfigurator {
    static func build() -> UIViewController {
        let vc = ProfileViewController()
        let presenter = ProfilePresentor()
        let service = FirebaseService.shared
        
        vc.profilePresentorDelegate = presenter
        
        presenter.profileVCDelegate = vc
        presenter.service = service
                
        return vc
    }
}

