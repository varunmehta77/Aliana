//
//  TrendingVM.swift
//  AlianaTest
//
//  Created by Varun M on 23/11/20.
//

import Foundation

class TrendingVM {

    fileprivate var trendingResponse = [TrendingResponse]()

    func fetchData(_ completion: @escaping completionHandler) {
        if let data = FileHelper.getJSON(viewModel: self) {
            do {
                let fetchresponse = try JSONDecoder().decode([TrendingResponse].self, from: data)
                trendingResponse = fetchresponse
                completion(true, nil)
            } catch {
                completion(false, error.localizedDescription)
            }
        }
    }
}

extension TrendingVM {

    func getNumberOfSectionInTableView() -> Int {
        return trendingResponse.count
    }

    func numberOfRowsInTableView(section: Int) -> Int {
        return trendingResponse[section].trendings.count
    }

    func getTrendingCellVM(atSection section: Int, atRow row: Int) -> TrendingCellVM {
        let trending = trendingResponse[section].trendings[row]
        return TrendingCellVM(
            title: trending.title, subTitle: trending.subTitle, imageName: trending.icon, percentChange: trending.percentChange, quantity: trending.quantity
        )
    }

    func getHeaderTitle(section: Int) -> String? {
        return trendingResponse[section].title
    }
}
