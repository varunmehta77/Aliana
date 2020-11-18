//
//  FileHelper.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation
import UIKit

class FileHelper {

    static func getJSON(contoller: UIViewController) -> Data? {
        var fileName = ""
        if contoller is CategoryVC {
            fileName = "Category"
        } else if contoller is ThemesVC {
            fileName = "Themes"
        } else if contoller is TrendingVC {
            fileName = "Trending"
        }
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
