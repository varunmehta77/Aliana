//
//  CategoryCellVM.swift
//  AlianaTest
//
//  Created by Varun M on 23/11/20.
//

import Foundation

class CategoryCellVM {
    var title: String?
    var imageName: String?
    var bgColorCode: String?

    init(title: String?, imageName: String?, bgColorCode: String?) {
        self.title = title
        self.imageName = imageName
        self.bgColorCode = bgColorCode
    }
}
