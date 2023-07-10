//
//  BeerInfoPresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

class BeerInfoPresentor {
    var beerVCDelegate: BeerInfoVCDelegate?
    var realmService: RealmServiceProtocol?
}

extension BeerInfoPresentor: BeerInfoPresentorDelegate {
    func addBeerToTheBasket(object: Object) {
        try! realmService?.saveObject(object: object)
        print("saved")
    }
}

