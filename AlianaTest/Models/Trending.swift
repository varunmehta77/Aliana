//
//  Trending.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation

struct Trending: Codable {
    var title: String?
    var subTitle: String?
    var icon: String?
    var percentChange: Double?
    var quantity: String?

    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case icon
        case percentChange
        case quantity
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        subTitle = try values.decodeIfPresent(String.self, forKey: .subTitle)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        percentChange = try values.decodeIfPresent(Double.self, forKey: .percentChange)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
    }
}
