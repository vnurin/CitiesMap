//
//  City.swift
//  CitiesMap
//
//  Created by Vahagn Nurijanyan on 2018-11-14.
//  Copyright © 2018 BABELONi INC. All rights reserved.
//

import Foundation

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct City: Decodable, Comparable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.country == rhs.country
    }
    
    let name: String
    let country: String
    private let _id: Int
    let coord: Coord
    static func < (lhs: City, rhs: City) -> Bool {
        if lhs.name != rhs.name {
            return lhs.name < rhs.name
        }
        else {
            return lhs.country < rhs.country
        }
    }
}

