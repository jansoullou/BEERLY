//
//  SearchPageProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 17/7/23.
//

import Foundation

protocol SearchPageControllerDelegate: AnyObject {
    func recieveFilteredBeers(beers: [BeerElement])
    func recieveError(error: Error)
}

protocol SearchPagePresenterDelegate: AnyObject {
    func getFilteredBeerList(search: String)
}

protocol SearchPageNetworkLayerProtocol: AnyObject {
    func fetchFilteredBeerList(search: String, completion: @escaping (Result<[BeerElement], Error>) -> Void)
}
