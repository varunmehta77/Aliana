//
//  FileHelper.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation
import UIKit

class FileHelper {

    static func getJSON(viewModel: Any) -> Data? {
        var fileName = ""
        if viewModel is CategoryVM {
            fileName = "Category"
        } else if viewModel is ThemesVM {
            fileName = "Themes"
        } else if viewModel is TrendingVM {
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
