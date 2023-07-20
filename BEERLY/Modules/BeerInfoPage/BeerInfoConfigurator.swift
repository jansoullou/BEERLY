//
//  BeerInfoConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

class BeerInfoPageConfigurator {
    static func build(beer: BeerElement) -> UIViewController {
        let vc = BeerInfoViewController(beer: beer)
        let service = FirebaseService.shared
        let presenter = BeerInfoPresentor()
        
        vc.beerPresentorDelegate = presenter
        
        presenter.firebaseService = service
        presenter.beerVCDelegate = vc
                
        return vc
    }
}
