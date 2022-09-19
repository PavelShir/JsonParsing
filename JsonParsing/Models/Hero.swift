//
//  Heroes.swift
//  JsonParsing
//
//  Created by 19543442 on 18.09.2022.
//

import Foundation

struct Hero: Decodable {
    
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let roles: [String]

    
}
