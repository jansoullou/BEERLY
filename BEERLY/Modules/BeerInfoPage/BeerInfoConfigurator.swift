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
        let service = RealmService.shared
        let presenter = BeerInfoPresentor()
        
        vc.beerPresentorDelegate = presenter
        
        presenter.realmService = service
        presenter.beerVCDelegate = vc
                
        return vc
    }
}
