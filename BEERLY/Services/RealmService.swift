//
//  RealmService.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import RealmSwift
import Foundation

final class RealmService {
    
    static let shared = RealmService()
    
    private init() { }
        
    private lazy var storage: Realm = {
        let realm = try! Realm()
        return realm
    }()
}

extension RealmService: RealmServiceProtocol {
    func saveObject(object: Object) throws {
        storage.writeAsync {
            self.storage.add(object)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        .init(self)
    }
}
