//
//  Films.swift
//  MoviesDB
//
//  Created by Aisha Farooque on 3/23/21.
//

import Foundation

struct Films: Decodable {
    let all: [Film]
    
    /// Search is the returned with all fields
    enum CodingKeys: String, CodingKey {
        case all = "Search"
    }
}
