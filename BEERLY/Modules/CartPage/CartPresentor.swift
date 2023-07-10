//
//  CartPresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

class CartPresentor: CartPresentorToService {
    var vc: CartVCToPresentor?
    
    var realmService: CartRealmServiceProtocol?
    
    private var addedBeersList = [BeerElement]()
    
    func fetchProductsToList() {
        addedBeersList = [BeerElement]()
        guard let objects = realmService?.fetch(by: BeerElementDTO.self) else { return }
        for object in objects {
            let model = object.toBeerElement()
            print("model: \(model)")
            addedBeersList.append(model)
        }
    }
    
    func deleteAll() throws {
        try realmService?.deleteAll()
        addedBeersList = [BeerElement]()
    }
}

extension CartPresentor: CartPresentorToVC {
    func sendProducts() {
        vc?.receiveProducts(products: addedBeersList)
    }
}

