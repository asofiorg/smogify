//
//  ReportData.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//

import Foundation



struct ReportData: Codable{
    let id: String
    let lat: Double
    let lng: Double
    let smog: Bool

}
