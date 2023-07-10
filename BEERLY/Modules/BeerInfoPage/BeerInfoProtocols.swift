//
//  BeerInfoProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol: AnyObject {
    func saveObject(object: Object) throws
}

protocol BeerInfoVCDelegate: AnyObject {
    func buttonTouched(object: BeerElement)
}

protocol BeerInfoPresentorDelegate: AnyObject {
    func addBeerToTheBasket(object: Object)
}
