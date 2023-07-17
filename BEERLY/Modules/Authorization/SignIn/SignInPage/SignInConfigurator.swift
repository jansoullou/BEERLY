//
//  SignInConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 15/7/23.
//

import UIKit

class SignInConfigurator {
    static func build() -> UIViewController {
        let vc = SignInViewController()
        let service = FirebaseService.shared
        let presentor = SignInPresentor()
        
        vc.presentor = presentor
        
        presentor.vcDelegate = vc
        presentor.fireBaseManager = service
        
        return vc
    }
}
