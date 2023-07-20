//
//  BeerInfoProtocols.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

protocol FirebaseServiceProtocol: AnyObject {
    func postBeerData(uid: String, beer: BeerElement, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol BeerInfoVCDelegate: AnyObject {
    func isDataSent()
    func getError(error: Error)
}

protocol BeerInfoPresentorDelegate: AnyObject {
    func saveObject(uid: String, beer: BeerElement)
}
