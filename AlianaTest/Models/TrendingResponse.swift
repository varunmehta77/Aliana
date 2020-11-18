//
//  TrendingResponse.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation

struct TrendingResponse: Codable {
    var title: String?
    var trendings = [Trending]()

    enum CodingKeys: String, CodingKey {
        case title
        case trendings = "values"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        trendings = try values.decodeIfPresent([Trending].self, forKey: .trendings) ?? []
    }
}


