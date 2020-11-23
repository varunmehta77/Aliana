//
//  CategoryVM.swift
//  AlianaTest
//
//  Created by Varun M on 23/11/20.
//

import Foundation

public typealias completionHandler = (Bool, String?) -> Void

class CategoryVM {

    fileprivate var categories = [Category]()

    func fetchData(_ completion: @escaping completionHandler) {
        if let data = FileHelper.getJSON(viewModel: self) {
            do {
                let fetchcategories = try JSONDecoder().decode([Category].self, from: data)
                categories = fetchcategories
                completion(true, nil)
            } catch {
                completion(false, error.localizedDescription)
            }
        }
    }
}

extension CategoryVM {

    func getNumberOfSectionInTableView() -> Int {
        return 1
    }

    func numberOfRowsInTableView() -> Int {
        return categories.count
    }

    func getCategoryVM(atIndex index: Int) -> CategoryCellVM {
        let category = categories[index]
        return CategoryCellVM(title: category.title, imageName: category.icon, bgColorCode: category.bgColor)

    }
}
