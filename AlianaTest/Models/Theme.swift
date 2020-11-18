//
//  Theme.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation

struct Theme: Codable {
    var title: String?
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case title
        case icon
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
}

