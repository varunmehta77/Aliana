//
//  TrendingCellVM.swift
//  AlianaTest
//
//  Created by Varun M on 23/11/20.
//

import Foundation

class TrendingCellVM {
    var title: String?
    var subTitle: String?
    var imageName: String?
    var percentChange: Double?
    var quantity: String?

    init(title: String?, subTitle: String?, imageName: String?, percentChange: Double?, quantity: String?) {
        self.title = title
        self.subTitle = subTitle
        self.imageName = imageName
        self.percentChange = percentChange
        self.quantity = quantity
    }
}
