//
//  CartPresentor.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

class CartPresentor: CartPresentorToService {
    
    var vc: CartVCDelegate?
    var service: CartServiceProtocol?
        
    func fetchProductsToList(uid: String) {
        service?.fetchBeersData(uid: uid) { [weak self] result in
            switch result {
            case .success(let success):
                self?.vc?.receiveProducts(products: success)
            case .failure(let failure):
                self?.vc?.receiveError(error: failure)
            }
        }
    }

    func deleteAll(uid: String) {
        service?.deleteAll(uid: uid) { [weak self] result in
            switch result {
            case .success(_):
                self?.vc?.receiveDeleteMessage()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

