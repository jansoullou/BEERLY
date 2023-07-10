//
//  BeerElementRealmDTO.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation
import RealmSwift

class BeerElementDTO: Object {
    @Persisted var id: ObjectId
    @Persisted var name: String
    @Persisted var descript: String
    @Persisted var tagline: String
    @Persisted var imageURL: String
    @Persisted var brewersTips: String
    @Persisted var contributedBy: String
    
    convenience init(name: String,
                     description: String,
                     tagline: String,
                     imageURL: String,
                     brewersTips: String,
                     contributedBy: String,
                     id: Int?) {
        self.init()
        self.id = try! ObjectId.generate()
        self.name = name
        self.descript = description
        self.tagline = tagline
        self.imageURL = imageURL
        self.brewersTips = brewersTips
        self.contributedBy = contributedBy
    }
}

extension BeerElement {
    func toBeerElementDTO() -> BeerElementDTO {
        BeerElementDTO(name: name ?? "",
                       description: description ?? "",
                       tagline: tagline ?? "",
                       imageURL: imageURL ?? "",
                       brewersTips: brewersTips ?? "",
                       contributedBy: contributedBy ?? "",
                       id: id)
    }
}

extension BeerElementDTO {
    func toBeerElement() -> BeerElement{
        BeerElement(id: 0,
                    name: name,
                    description: descript,
                    tagline: tagline,
                    imageURL: imageURL,
                    brewersTips: brewersTips,
                    contributedBy: contributedBy)
    }
}

