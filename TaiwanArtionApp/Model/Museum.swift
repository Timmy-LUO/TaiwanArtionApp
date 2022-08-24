//
//  Museum.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/22.
//

import Foundation

struct Museum: Codable {
    let name: String
    let address: String
    let longitude: Double
    let latitude: Double
    let ticketPrice: String
    let website: String
    let srcWebsite: String
    let cityName: String
}
