//
//  AllCategories.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/22.
//

import Foundation

struct AllCategories: Codable {
    let title: String
    let showInfo: [ShowInfo]
    let descriptionFilterHtml: String
    let imageUrl: String
    let webSales: String
    let sourceWebPromote: String
    let sourceWebName: String
    let startDate: String
    let endDate: String
}

struct ShowInfo: Codable {
    let time: String
    let location: String
    let locationName: String
    let onSales: String
    let price: String
    let latitude: String?
    let longitude: String?
    let endTime: String
}
