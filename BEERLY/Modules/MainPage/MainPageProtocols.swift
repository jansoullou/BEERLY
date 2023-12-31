//
//  MainPageProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

protocol MainPageControllerDelegate: AnyObject {
    func recieveBeer(beers: [BeerElement])
    func recieveError(error: Error)
}

protocol MainPagePresenterDelegate: AnyObject {
    func getBeerList(page: Int)
}

protocol MainPageNetworkLayerProtocol: AnyObject {
    func fetchData(page: Int, completion: @escaping (Result<[BeerElement], Error>) -> Void)
}
