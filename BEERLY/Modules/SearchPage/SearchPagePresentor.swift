//
//  SearchPagePresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 17/7/23.
//

import Foundation

class SearchPagePresentor {
    var mainPageControllerDelegate: SearchPageControllerDelegate?
    var networkLayerDelegate: SearchPageNetworkLayerProtocol?
}

extension SearchPagePresentor: SearchPagePresenterDelegate{
    func getFilteredBeerList(search: String) {
        networkLayerDelegate?.fetchFilteredBeerList(search: search) { [weak self] result in
            switch result {
            case .success(let model):
                self?.mainPageControllerDelegate?.recieveFilteredBeers(beers: model)
            case .failure(let error):
                self?.mainPageControllerDelegate?.recieveError(error: error)
                print(error)
            }
            
        }
    }
}


