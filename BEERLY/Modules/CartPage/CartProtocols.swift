//
//  CartProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

protocol CartVCDelegate {
    func receiveProducts(products: [BeerElement])
    func receiveError(error: Error)
    func receiveDeleteMessage()
}

protocol CartPresentorToService {
    func fetchProductsToList(uid: String)
    func deleteAll(uid: String)
}

protocol CartServiceProtocol {
    func deleteAll(uid: String, completion: @escaping(Result<Bool, Error>) -> Void)
    func fetchBeersData(uid: String, completion: @escaping(Result<[BeerElement], Error>) -> Void)
}
