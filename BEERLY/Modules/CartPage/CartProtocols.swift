//
//  CartProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

protocol CartVCToPresentor {
    func fetchProducts()
    func receiveProducts(products: [BeerElement])
}

protocol CartPresentorToVC {
    func sendProducts()
}

protocol CartPresentorToService {
    func fetchProductsToList()
    func deleteAll() throws
}

protocol CartRealmServiceProtocol {
    func deleteObject(object: Object) throws
    func deleteAll() throws
    func fetch<T: Object>(by type: T.Type) -> [T]
}

protocol CartToBeerInfoDelegate: AnyObject {
    func updateData()
}
