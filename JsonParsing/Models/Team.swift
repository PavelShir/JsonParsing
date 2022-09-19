//
//  Team.swift
//  JsonParsing
//
//  Created by 19543442 on 18.09.2022.
//

import Foundation

struct Team: Decodable {
    let team_id: Int
    let rating:Int
    let wins :Int
    let losses: Int
    let last_match_time: Int
    let name: String
    let tag: String

}
