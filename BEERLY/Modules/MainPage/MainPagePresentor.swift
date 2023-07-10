//
//  MainPagePresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

class MainPagePresentor {
    var mainPageControllerDelegate: MainPageControllerDelegate?
    var networkLayerDelegate: MainPageNetworkLayerProtocol?
}

extension MainPagePresentor: MainPagePresenterDelegate {
    func getBeerList() {
        networkLayerDelegate?.fetchData { result in
            switch result {
            case .success(let model):
                self.mainPageControllerDelegate?.recieveBeer(beers: model)
            case .failure(let error):
                self.mainPageControllerDelegate?.recieveError(error: error)
                print(error)
            }
        }
    }
}

