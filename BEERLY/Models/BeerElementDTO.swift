//
//  BeerElementDTO.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

struct BeerElement: Codable {
    var id: Int?
    var name, description, tagline: String?
    var imageURL: String?
    var brewersTips, contributedBy: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case tagline
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}
