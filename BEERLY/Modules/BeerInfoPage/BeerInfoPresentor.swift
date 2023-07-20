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
    var firebaseService: FirebaseServiceProtocol?
}

extension BeerInfoPresentor: BeerInfoPresentorDelegate {
    func saveObject(uid: String, beer: BeerElement) {
        print("saved")
        firebaseService?.postBeerData(uid: uid, beer: beer) { [weak self] result in
            switch result {
            case .success(_):
                self?.beerVCDelegate?.isDataSent()
            case .failure(let failure):
                self?.beerVCDelegate?.getError(error: failure)
            }
        }
    }
}

