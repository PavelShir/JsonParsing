//
//  Team.swift
//  JsonParsing
//
//  Created by 19543442 on 18.09.2022.
//

import Foundation

struct Apod: Decodable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String

}
