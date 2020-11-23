//
//  ThemesVM.swift
//  AlianaTest
//
//  Created by Varun M on 23/11/20.
//

import Foundation

class ThemesVM {

    fileprivate var themes = [Theme]()

    func fetchData(_ completion: @escaping completionHandler) {
        if let data = FileHelper.getJSON(viewModel: self) {
            do {
                let fetchthemes = try JSONDecoder().decode([Theme].self, from: data)
                themes = fetchthemes
                completion(true, nil)
            } catch {
                completion(false, error.localizedDescription)
            }
        }
    }
}

extension ThemesVM {

    func getNumberOfSectionInTableView() -> Int {
        return 1
    }

    func numberOfRowsInTableView() -> Int {
        return themes.count
    }

    func getThemeCellVM(atIndex index: Int) -> ThemesCellVM {
        let theme = themes[index]
        return ThemesCellVM(title: theme.title, imageName: theme.icon)
    }
}
