//
//  ArtsHumanities.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/22.
//

import Foundation

struct ArtsHumanities: Codable {
    let id: String
    let title: String
    let description: String
    let imageUrl: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case description = "Description"
        case imageUrl = "ImageUrl"
    }
}
