//
//  SignUpConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 14/7/23.
//

import UIKit

class SignUpConfigurator {
    static func build(phoneNum: String) -> UIViewController {
        let vc = SignUpViewController(phoneNumber: phoneNum)
        let service = FirebaseAuthService.shared
        let presentor = SignUpPresentor()
        
        vc.presentor = presentor
        
        presentor.vcDelegate = vc
        presentor.fireBaseManager = service
        
        return vc
    }
}


