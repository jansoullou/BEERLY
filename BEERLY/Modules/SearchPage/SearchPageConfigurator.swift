//
//  SearchPageConfigurator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 17/7/23.
//

import UIKit

class SearchPageConfigurator {
    static func build() -> UIViewController {
        let vc = SearchPageViewController()
        let service = NetworkLayer()
        let presenter = SearchPagePresentor()
        
        vc.presentorDelegate = presenter
        
        presenter.networkLayerDelegate = service
        presenter.mainPageControllerDelegate = vc
        
        return vc
    }
}

