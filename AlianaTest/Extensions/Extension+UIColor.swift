//
//  Extension+UIColor.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation
import UIKit

extension UIColor {

    static var appBlueColor: UIColor {
        return UIColor.init(hex: "5050ca")
    }

    static var appBackgroundColor: UIColor {
        return UIColor.init(hex: "f5f6ff")
    }

    static var appBackgroundGreenColor: UIColor {
        return UIColor.init(hex: "84d950")
    }

    static var appBackgroundRedColor: UIColor {
        return UIColor.init(hex: "c75f5f")
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
