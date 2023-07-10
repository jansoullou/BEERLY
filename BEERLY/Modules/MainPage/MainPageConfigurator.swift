//
//  MainPageConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

class MainPageConfigurator {
    static func build() -> UIViewController {
        let vc = MainPageViewController()
        let service = NetworkLayer()
        let presenter = MainPagePresentor()
        
        vc.mainPagePresentorDelegate = presenter
        
        presenter.networkLayerDelegate = service
        presenter.mainPageControllerDelegate = vc
        
        return vc
    }
}

