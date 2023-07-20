//
//  CartConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

class CartConfigurator {
    static func build() -> UIViewController {
        let vc = CartViewController()
        let presentor = CartPresentor()
        let service = FirebaseService.shared
        
        vc.presentorToService = presentor
        
        presentor.vc = vc
        presentor.service = service
        
        return vc
    }
}

