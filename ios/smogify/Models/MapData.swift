//
//  MapData.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//

import Foundation







struct MapData: Codable{
    var ip: String
    
}

//
struct Feature: Codable{
    let type: String
    let geometry: Geometry //single?

}

struct Geometry: Codable{
    let type: String
    let coordinates: [Double]
}

