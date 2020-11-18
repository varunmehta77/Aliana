//
//  Extension+UILabel.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

extension UILabel {

    func getWidthFromText() -> CGFloat {
        if let txt = text,
            let font = UIFont(name: font.fontName, size: font.pointSize) {
            return txt.size(withAttributes: [NSAttributedString.Key.font: font]).width
        }

        return 0
    }

    func getHeightFromText() -> CGFloat {
        if let txt = text,
            let font = UIFont(name: font.fontName, size: font.pointSize) {
            return txt.size(withAttributes: [NSAttributedString.Key.font: font]).height
        }

        return 0
    }
}
